//
//  ApplyDetailInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift

protocol ApplyDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ApplyDetailPresentable: Presentable {
    var listener: ApplyDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setNavigaionBarTitle(_ text: String)
}

protocol ApplyDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func back()
}

final class ApplyDetailInteractor: PresentableInteractor<ApplyDetailPresentable>, ApplyDetailInteractable, ApplyDetailPresentableListener {
    func didBackButton() {
        listener?.back()
    }
    

    weak var router: ApplyDetailRouting?
    weak var listener: ApplyDetailListener?

    let apply: Apply
    
    init(presenter: ApplyDetailPresentable, apply: Apply) {
        Log(apply)
        self.apply = apply
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        setNavigaionTitle()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func setNavigaionTitle() {
        Log(apply)
        presenter.setNavigaionBarTitle(apply.companyName)
    }
}
