//
//  SignUpAgreementDetailInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/24.
//

import RIBs
import RxSwift

protocol SignUpAgreementDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SignUpAgreementDetailPresentable: Presentable {
    var listener: SignUpAgreementDetailPresentableListener? { get set }
    func loadWebView(url: String)
}

protocol SignUpAgreementDetailListener: AnyObject {
    func didTabBackButtonFromSignUpAgreementDetailRIB()
}

final class SignUpAgreementDetailInteractor: PresentableInteractor<SignUpAgreementDetailPresentable>, SignUpAgreementDetailInteractable, SignUpAgreementDetailPresentableListener {

    weak var router: SignUpAgreementDetailRouting?
    weak var listener: SignUpAgreementDetailListener?

    private let agreementType: AgreementType
    
    init(presenter: SignUpAgreementDetailPresentable, agreementType: AgreementType) {
        self.agreementType = agreementType
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if let url = agreementType.url {
            presenter.loadWebView(url: url)
        }
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func tapBackButton() {
        listener?.didTabBackButtonFromSignUpAgreementDetailRIB()
    }
}
