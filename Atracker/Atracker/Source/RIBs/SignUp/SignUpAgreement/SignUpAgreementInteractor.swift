//
//  SignUpAgreementInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import RIBs
import RxSwift
import RxCocoa

protocol SignUpAgreementRouting: ViewableRouting {
    func attachSignUpNicknameRIB(idToken: String, sso: SSO)
    func attachSignUpAgreementDetailRIB(agreementType: AgreementType)
    func detachSignUpNicknameRIB()
    func detachSignUpAgreementDetailRIB()
}

protocol SignUpAgreementPresentable: Presentable {
    var listener: SignUpAgreementPresentableListener? { get set }
    var action: SignUpAgreementPresentableAction? { get }
    var handler: SignUpAgreementPresentableHandler? { get set }
}

protocol SignUpAgreementListener: AnyObject {
    func didTapBackButtonFromSignUpAgreementRIB()
    func didSignUp()
}

final class SignUpAgreementInteractor: PresentableInteractor<SignUpAgreementPresentable>, SignUpAgreementInteractable, SignUpAgreementPresentableListener {
    weak var router: SignUpAgreementRouting?
    weak var listener: SignUpAgreementListener?
    
    private let idToken: String
    private let sso: SSO

    private let isSelectedAllAgreementRelay = BehaviorRelay<Bool>(value: false)
    private let isSelectedServiceAgreementRelay = BehaviorRelay<Bool>(value: false)
    private let isSelectedPersonalAgreementRelay = BehaviorRelay<Bool>(value: false)
    private let isSelectedMarketingAgreementRelay = BehaviorRelay<Bool>(value: false)
    private let isSelectedNextButtonRelay = BehaviorRelay<Bool>(value: false)
    
    init(presenter: SignUpAgreementPresentable, idToken: String, sso: SSO) {
        self.idToken = idToken
        self.sso = sso
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.handler = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        self.setupBind()
        Log("[D] 액티브 댐")
    }

    override func willResignActive() {
        super.willResignActive()
        Log("[D] 끊어짐")
        presenter.handler = nil
    }
    
    func setupBind() {
        guard let action = presenter.action else { return }
        guard let handler = presenter.handler else { return }
        
        // 바인딩 액션
        action.tapBackButton
            .bind { [weak self] in
                self?.listener?.didTapBackButtonFromSignUpAgreementRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapNextButton
            .bind { [weak self] in
                self?.didTapNextButton()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapServiceAgreementButton
            .bind { [weak self] in
                Log("[D] 서비스 동의 버튼 클릭")
                self?.router?.attachSignUpAgreementDetailRIB(agreementType: AgreementType.service)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapPersonalAgreementButton
            .bind { [weak self] in
                self?.router?.attachSignUpAgreementDetailRIB(agreementType: AgreementType.personal)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapMarketingAgreementButton
            .bind { [weak self] in
                self?.router?.attachSignUpAgreementDetailRIB(agreementType: AgreementType.marketing)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.selectAllAgreement
            .bind { [weak self] bool in
                Log("[D] 인터렉터 부분 \(bool)")
                self?.isSelectedAllAgreementRelay.accept(bool)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.selectServiceAgreement
            .bind(to: isSelectedServiceAgreementRelay)
            .disposeOnDeactivate(interactor: self)
        
        action.selectPersonalAgreement
            .bind(to: isSelectedPersonalAgreementRelay)
            .disposeOnDeactivate(interactor: self)
        
        action.selectMarketingAgreement
            .bind(to: isSelectedMarketingAgreementRelay)
            .disposeOnDeactivate(interactor: self)
        
        Observable.combineLatest(handler.isSelectedServiceAgreement, handler.isSelectedPersonalAgreement)
            .bind { [weak self] isService, isPersonal in
                if isService && isPersonal {
                    self?.isSelectedNextButtonRelay.accept(true)
                } else {
                    self?.isSelectedNextButtonRelay.accept(false)
                }
            }
            .disposeOnDeactivate(interactor: self)
    }

    func didTapNextButton() {
        if isSelectedNextButtonRelay.value {
            router?.attachSignUpNicknameRIB(idToken: idToken, sso: sso)
        }
    }
    
    // MARK: 자식 RIB으로 부터
    func didSignUp() {
        listener?.didSignUp()
    }
    
    func didTapBackButtonFromSignUpNicknameRIB() {
        router?.detachSignUpNicknameRIB()
    }
    
    func didTabBackButtonFromSignUpAgreementDetailRIB() {
        router?.detachSignUpAgreementDetailRIB()
    }
}

extension SignUpAgreementInteractor: SignUpAgreementPresentableHandler {
    var isSelectedAllAgreement: Observable<Bool> {
        return isSelectedAllAgreementRelay.asObservable()
    }
    
    var isSelectedServiceAgreement: Observable<Bool> {
        return isSelectedServiceAgreementRelay.asObservable()
    }
    
    var isSelectedPersonalAgreement: Observable<Bool> {
        return isSelectedPersonalAgreementRelay.asObservable()
    }
    
    var isSelectedMarketingAgreement: Observable<Bool> {
        return isSelectedMarketingAgreementRelay.asObservable()
    }
    
    var isSelectedNextButton: Observable<Bool> {
        return isSelectedNextButtonRelay.asObservable()
    }
}
