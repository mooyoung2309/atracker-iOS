//
//  EditApplyStageProgressRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs

protocol EditApplyStageProgressInteractable: Interactable {
    var router: EditApplyStageProgressRouting? { get set }
    var listener: EditApplyStageProgressListener? { get set }
}

protocol EditApplyStageProgressViewControllable: NavigationContainerViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditApplyStageProgressRouter: ViewableRouter<EditApplyStageProgressInteractable, EditApplyStageProgressViewControllable>, EditApplyStageProgressRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditApplyStageProgressInteractable, viewController: EditApplyStageProgressViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
