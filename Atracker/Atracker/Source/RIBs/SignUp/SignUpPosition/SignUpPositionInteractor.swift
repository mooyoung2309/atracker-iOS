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
}

protocol SignUpPositionListener: AnyObject {
    func didTapBackButtonFromSignUpPositionRIB()
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
        
        action.tapBackButton
            .bind { [weak self] in
                self?.listener?.didTapBackButtonFromSignUpPositionRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
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
            authService.sign(request: SignRequest(accessToken: idToken, jobPosition: jobPosition, nickName: nickname, primaryEmail: "", experienceType: experienceType, sso: sso)) { [weak self] result in
                switch result {
                case .success(let data):
                    Log("[D] 회원가입 성공 \(data)")
                    self?.router?.attachSignUpSuccessRIB(nickName: nickname)
                case .failure(let error):
                    break
                }
            }
        }
    }
    
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
