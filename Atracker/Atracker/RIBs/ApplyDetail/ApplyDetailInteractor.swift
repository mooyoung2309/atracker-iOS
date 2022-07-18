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
    func attachEditApplyOverallRIB()
    func attachEditApplyStageProgressRIB(apply: Apply)
    func detachThisRIB()
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
    
}

final class ApplyDetailInteractor: PresentableInteractor<ApplyDetailPresentable>, ApplyDetailInteractable, ApplyDetailPresentableListener {
    
    weak var router: ApplyDetailRouting?
    weak var listener: ApplyDetailListener?

    private let apply: Apply
    private var isShowEditTableView = false
    
    private let stageContentsRelay = BehaviorRelay<[StageContent]>(value: [])
    private let showEditTypeTableViewRelay = BehaviorRelay<Bool>(value: false)
    
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
        guard let action = presenter.action else { return }
        
        // 액션 바인딩
        action.tapBackButton
            .bind { [weak self] in
                self?.router?.detachThisRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapEditButton
            .bind { [weak self] in
                self?.didTapEditButton()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapEditTypeCell
            .bind { [weak self] editTypeItem in
                self?.didTapEditTypeCell(editTypeItem: editTypeItem)
            }
            .disposeOnDeactivate(interactor: self)
        
    }
    
    private func didTapEditButton() {
        let bool = !showEditTypeTableViewRelay.value
        showEditTypeTableViewRelay.accept(bool)
    }
    
    private func didTapEditTypeCell(editTypeItem: EditTypeItem) {
        switch editTypeItem {
        case .apply:
            router?.attachEditApplyOverallRIB()
            didTapEditButton()
        case .stage:
            router?.attachEditApplyStageProgressRIB(apply: apply)
            didTapEditButton()
        case .delete:
            return
        }
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
    func didEditApplyStageProgress() {
//        router?.detachThisChildRIB()
        
        presenter.hideEditTableView()
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
    
    var showEditTypeTableView: Observable<Bool> {
        return showEditTypeTableViewRelay.asObservable()
    }
}
