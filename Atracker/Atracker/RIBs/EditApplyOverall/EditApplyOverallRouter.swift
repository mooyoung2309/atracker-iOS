//
//  EditApplyOverallRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs

protocol EditApplyOverallInteractable: Interactable {
    var router: EditApplyOverallRouting? { get set }
    var listener: EditApplyOverallListener? { get set }
}

protocol EditApplyOverallViewControllable: NavigationViewControllable {

}

final class EditApplyOverallRouter: ViewableRouter<EditApplyOverallInteractable, EditApplyOverallViewControllable>, EditApplyOverallRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditApplyOverallInteractable, viewController: EditApplyOverallViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func detachThisRIB() {
        detachChild(self)
        
        viewController.dismiss(nil, isTabBarShow: true)
    }
}
