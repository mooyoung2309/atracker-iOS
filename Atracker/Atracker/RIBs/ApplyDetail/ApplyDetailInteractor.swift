//
//  ApplyDetailInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift

protocol ApplyDetailRouting: ViewableRouting {
    func attachApplyEditRIB(apply: ApplyResponse)
    func attachEditApplyOverallRIB()
    func attachEditApplyStageProgressRIB()
    func detachThisChildRIB()
}

protocol ApplyDetailPresentable: Presentable {
    var listener: ApplyDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setNavigaionBarTitle(_ text: String)
    func showEditTableView()
    func hideEditTableView()
}

protocol ApplyDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func tapBackButtonFromChildRIB()
    func showTabBar()
    func hideTabBar()
}

final class ApplyDetailInteractor: PresentableInteractor<ApplyDetailPresentable>, ApplyDetailInteractable, ApplyDetailPresentableListener {
    
    weak var router: ApplyDetailRouting?
    weak var listener: ApplyDetailListener?

    let apply: ApplyResponse
    private var isShowEditTableView = false
    
    init(presenter: ApplyDetailPresentable, apply: ApplyResponse) {
        self.apply = apply
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.setNavigaionBarTitle(apply.companyName)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func tapBackButton() {
        listener?.tapBackButtonFromChildRIB()
    }
    
    func tapEditButton() {
        if isShowEditTableView {
            presenter.hideEditTableView()
            listener?.showTabBar()
        } else {
            presenter.showEditTableView()
            listener?.hideTabBar()
        }
        
        isShowEditTableView = !isShowEditTableView
    }
    
    func tapEditApplyOverallButton() {
        Log("[D] 지원 후기 수정하기 버튼 클릭됨")
        router?.attachEditApplyOverallRIB()
    }
    
    func tapEditApplyStageProgressButton() {
        Log("[D] 전형 편집하기 버튼 클릭됨")
        router?.attachEditApplyStageProgressRIB()
    }
    
    func tapDeleteApplyButton() {
        Log("[D] 지원 후기 삭제하기 버튼 클릭됨")
    }
    
    func tapBackButtonFromChildRIB() {
        router?.detachThisChildRIB()
        
        presenter.hideEditTableView()
        listener?.showTabBar()
        isShowEditTableView = false
    }
}
