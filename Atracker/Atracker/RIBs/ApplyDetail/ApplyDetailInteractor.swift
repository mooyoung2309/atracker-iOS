//
//  ApplyDetailInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift
import RxCocoa

protocol ApplyDetailRouting: ViewableRouting {
    func attachApplyEditRIB(apply: Apply)
    func attachEditApplyOverallRIB()
    func attachEditApplyStageProgressRIB(apply: Apply)
    func detachThisChildRIB()
}

protocol ApplyDetailPresentable: Presentable {
    var listener: ApplyDetailPresentableListener? { get set }
    var action: ApplyDetailPresentableAction? { get }
    var handler: ApplyDetailPresentableHandler? { get set }
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

    private let apply: Apply
    private var isShowEditTableView = false
    
    private let stageContentsRelay = BehaviorRelay<[StageContent]>(value: [])
    
    init(presenter: ApplyDetailPresentable, apply: Apply) {
        self.apply = apply
        
        super.init(presenter: presenter)
        
        presenter.listener = self
        presenter.handler = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        Log("[D] 지원 현황 디테일 페이지 \(apply.stageProgress)")
        setupBind()
        presenter.setNavigaionBarTitle(apply.companyName)
    }

    override func willResignActive() {
        super.willResignActive()
        
        presenter.handler = nil
    }
    
    func setupBind() {
//        stageContentsRelay.accept(apply.)
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
        router?.attachEditApplyStageProgressRIB(apply: apply)
    }
    
    func tapDeleteApplyButton() {
        Log("[D] 지원 후기 삭제하기 버튼 클릭됨")
    }
    
    // MARK: 자식 RIBs으로 부터
    func tapBackButtonFromChildRIB() {
        router?.detachThisChildRIB()
        
        presenter.hideEditTableView()
        listener?.showTabBar()
        isShowEditTableView = false
    }
    
    func didEditApplyStageProgress() {
        router?.detachThisChildRIB()
        
        presenter.hideEditTableView()
        listener?.showTabBar()
    }
}

// MARK: PresentableHandler
extension ApplyDetailInteractor: ApplyDetailPresentableHandler {
    var stageTitles: Observable<[String]> {
        return Observable.just(apply.stageProgress.map({ (stageProgress: StageProgress) -> String in
            return stageProgress.stageTitle
        }))
    }
    
    var stageProgresses: Observable<[StageProgress]> {
        return Observable.just(apply.stageProgress)
    }
}
