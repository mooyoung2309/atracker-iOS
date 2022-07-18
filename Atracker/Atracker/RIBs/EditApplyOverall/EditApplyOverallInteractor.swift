//
//  EditApplyOverallInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift

protocol EditApplyOverallRouting: ViewableRouting {
    func detachThisRIB()
}

protocol EditApplyOverallPresentable: Presentable {
    var listener: EditApplyOverallPresentableListener? { get set }
    var action: EditApplyOverallPresentableAction? { get }
    var handler: EditApplyOverallPresentableHandler? { get set }
}

protocol EditApplyOverallListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EditApplyOverallInteractor: PresentableInteractor<EditApplyOverallPresentable>, EditApplyOverallInteractable, EditApplyOverallPresentableListener {
    
    weak var router: EditApplyOverallRouting?
    weak var listener: EditApplyOverallListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: EditApplyOverallPresentable) {
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
                self?.router?.detachThisRIB()
            }
            .disposeOnDeactivate(interactor: self)
    }
}

extension EditApplyOverallInteractor: EditApplyOverallPresentableHandler {
    
}
