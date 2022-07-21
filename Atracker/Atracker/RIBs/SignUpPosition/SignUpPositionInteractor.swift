//
//  SignUpPositionInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift
import RxCocoa

protocol SignUpPositionRouting: ViewableRouting {
    func attachSignUpSuccessRIB(nickName: String)
}

protocol SignUpPositionPresentable: Presentable {
    var listener: SignUpPositionPresentableListener? { get set }
    var action: SignUpPositionPresentableAction? { get }
    var handler: SignUpPositionPresentableHandler? { get set }
//    func switchCareerTableView()
//    func updateCareerLabel(title: String)
}

protocol SignUpPositionListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSignUp()
}

final class SignUpPositionInteractor: PresentableInteractor<SignUpPositionPresentable>, SignUpPositionInteractable, SignUpPositionPresentableListener {

    weak var router: SignUpPositionRouting?
    weak var listener: SignUpPositionListener?
    
    private let authService: AuthServiceProtocol
    private let idToken: String
    private let sso: SSO
    private let nickname: String

    private let jobPositionRelay = BehaviorRelay<String>(value: "")
    private let experienceTypeRelay = BehaviorRelay<ExperienceType>(value: ExperienceType.notExperienced)
    private let isSelectedNextButtonRelay = PublishRelay<Bool>()
    private let showExperienceTypeTableRelay = PublishRelay<Void>()
    private let hideExperienceTypeTableRelay = PublishRelay<Void>()
    
//    private var jobPosition: String?
//    private var jobType: String?

    init(presenter: SignUpPositionPresentable, authService: AuthServiceProtocol, idToken: String, sso: SSO, nickname: String) {
        self.authService = authService
        self.idToken = idToken
        self.sso = sso
        self.nickname = nickname
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.handler = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        setupBind()
    }

    override func willResignActive() {
        super.willResignActive()
        presenter.handler = nil
    }
    
    func setupBind() {
        guard let action = presenter.action else { return }
        
        action.tapNextButton
            .bind { [weak self] in
                self?.didTapNextButton()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.textJobPosition
            .bind { [weak self] jobPosition in
                self?.jobPositionRelay.accept(jobPosition)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapExperienceTypeCell
            .bind { [weak self] experienceType in
                self?.experienceTypeRelay.accept(experienceType)
                self?.hideExperienceTypeTableRelay.accept(())
            }
            .disposeOnDeactivate(interactor: self)
        
        action.toggleExperienceTable
            .bind { [weak self] bool in
                if bool {
                    self?.hideExperienceTypeTableRelay.accept(())
                } else {
                    self?.showExperienceTypeTableRelay.accept(())
                }
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    func didTapNextButton() {
        let jobPosition = jobPositionRelay.value
        let experienceType = experienceTypeRelay.value
        let nickname = nickname
        
        if jobPosition != "" {
            authService.sign(request: SignRequest(accessToken: idToken, jobPosition: jobPosition, nickName: nickname, experienceType: experienceType, sso: sso)) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.router?.attachSignUpSuccessRIB(nickName: nickname)
                case .failure(let error):
                    break
                }
            }
        }
    }
//
//    func inputPositionTextField(text: String) {
//        self.jobPosition = text
//    }
//
//    func inputCareerTextField(text: String) {
//        self.jobType = text
//    }
//
//    func tapCareerTableView(career: String) {
//        self.jobType = career
//        presenter.updateCareerLabel(title: career)
//        presenter.switchCareerTableView()
//    }
//
//    func tapNextButton() {
//        guard let jobPosition = jobPosition else { return }
//        guard let jobType = jobType else { return }
//        
//        if jobPosition.isEmpty || jobType.isEmpty { return }
//        
//        authService.testSignUp(email: "TEST\(Int.random(in: 0...100))", gender: Gender.male.code, jobPosition: jobPosition, nickName: nickname, sso: SSO.apple.code) { [weak self] result in
//            guard let this = self else { return }
//            switch result {
//            case .success(_):
//                this.router?.attachSignUpSuccessRIB(nickName: this.nickname, jobPosition: jobPosition, jobType: jobType)
//                Log("[D] 테스트 회원가입 성공")
//            case .failure(_):
//                Log("[D] 테스트 회원가입 실패")
//            }
//        }
//    }
    
    func didSignUp() {
        listener?.didSignUp()
    }
}

extension SignUpPositionInteractor: SignUpPositionPresentableHandler {
    var jobPosition: Observable<String> {
        return jobPositionRelay.asObservable()
    }
    
    var experienceType: Observable<ExperienceType> {
        return experienceTypeRelay.asObservable()
    }
    
    var isSelectedNextButton: Observable<Bool> {
        return isSelectedNextButtonRelay.asObservable()
    }
    
    var showExperienceTypeTable: Observable<Void> {
        return showExperienceTypeTableRelay.asObservable()
    }
    
    var hideExperienceTypeTable: Observable<Void> {
        return hideExperienceTypeTableRelay.asObservable()
    }
}
