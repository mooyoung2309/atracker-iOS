//
//  ApplyEditInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift

protocol ApplyEditRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ApplyEditPresentable: Presentable {
    var listener: ApplyEditPresentableListener? { get set }
    
    func setNavigaionBarTitle(_ text: String)
    func highlightStageStatusButton(status: ProgressStatus)
    func showStageStatusButtonBar()
    func showDeleteButtonBar()
    func showStageContentList(_ stageContentList: [StageContent])
    func showCheckButton()
    func hideCheckButton()
    func showAlertView(style: AlertStyle)
    func hideAlertView()
}

protocol ApplyEditListener: AnyObject {
    func tapBackButtonFromChildRIB()
}

final class ApplyEditInteractor: PresentableInteractor<ApplyEditPresentable>, ApplyEditInteractable, ApplyEditPresentableListener {
    
    weak var router: ApplyEditRouting?
    weak var listener: ApplyEditListener?

    private let apply: Apply
    private var edittedApply: Apply
    private var isEditting: Bool = false
    
    init(presenter: ApplyEditPresentable, apply: Apply) {
        self.apply          = apply
        self.edittedApply   = apply
        
        super.init(presenter: presenter)
        
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.setNavigaionBarTitle(apply.companyName)
        reloadTableView(stageProgressTitle: "전형 0")
        presenter.hideCheckButton()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapBackButton() {
        listener?.tapBackButtonFromChildRIB()
    }
    
    func reloadTableView(stageProgressTitle: String) {
//        guard let stageProgress = edittedApply.stageProgress?.first(where: { $0.title == stageProgressTitle}) else {
//            return
//        }
//        
//        presenter.showStageContentList([stageProgress.stageContent])
    }
    
    func tapStageStatusButton(status: ProgressStatus) {
        switch status {
        case .notStarted:
            presenter.highlightStageStatusButton(status: .notStarted)
            return
        case .fail:
            presenter.highlightStageStatusButton(status: .fail)
            return
        case .pass:
            presenter.highlightStageStatusButton(status: .pass)
            return
        }
    }
    
    func tapEditButton() {
        presenter.showDeleteButtonBar()
        presenter.showCheckButton()
    }
    
    func tapEditCompleteButton() {
        presenter.showStageStatusButtonBar()
        presenter.hideCheckButton()
    }
    
    func tapDeleteButton() {
        Log("")
        presenter.showAlertView(style: AlertStyle.delete(10))
    }
    
    func tapAlertBackButton() {
        presenter.hideAlertView()
    }
    
    func tapAlertNextButton() {
        Log("")
    }
}
