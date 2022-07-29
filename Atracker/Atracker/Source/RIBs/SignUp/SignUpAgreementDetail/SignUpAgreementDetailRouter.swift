//
//  SignUpAgreementDetailRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/24.
//

import RIBs

protocol SignUpAgreementDetailInteractable: Interactable {
    var router: SignUpAgreementDetailRouting? { get set }
    var listener: SignUpAgreementDetailListener? { get set }
}

protocol SignUpAgreementDetailViewControllable: NavigationViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SignUpAgreementDetailRouter: ViewableRouter<SignUpAgreementDetailInteractable, SignUpAgreementDetailViewControllable>, SignUpAgreementDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SignUpAgreementDetailInteractable, viewController: SignUpAgreementDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
