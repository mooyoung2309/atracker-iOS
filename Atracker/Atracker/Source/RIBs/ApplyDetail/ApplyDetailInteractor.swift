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
    func attachEditApplyOverallRIB(apply: Apply)
    func attachEditApplyStageProgressRIB(apply: Apply)
    func detachEditApplyOverallRIB()
    func detachEditApplyStageProgressRIB()
}

protocol ApplyDetailPresentable: Presentable {
    var listener: ApplyDetailPresentableListener? { get set }
    var action: ApplyDetailPresentableAction? { get }
    var handler: ApplyDetailPresentableHandler? { get set }
}

protocol ApplyDetailListener: AnyObject {
    func didBackFromApplyDetail()
}

final class ApplyDetailInteractor: PresentableInteractor<ApplyDetailPresentable>, ApplyDetailInteractable, ApplyDetailPresentableListener {
    
    weak var router: ApplyDetailRouting?
    weak var listener: ApplyDetailListener?

    private let applyService: ApplyServiceProtocol
    
    private var thisApply: Apply
    private var isShowEditTableView = false
    
    private lazy var applyRelay = BehaviorRelay<Apply>(value: thisApply)
    private lazy var stageContentsRelay = BehaviorRelay<[StageContent]>(value: [])
    private lazy var showEditTypeTableViewRelay = BehaviorRelay<Bool>(value: false)
    
    init(presenter: ApplyDetailPresentable, applyService: ApplyServiceProtocol, apply: Apply) {
        self.applyService = applyService
        self.thisApply = apply
        
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
        guard let handler = presenter.handler else { return }
        
        // 액션 바인딩
        action.tapBackButton
            .bind { [weak self] in
                self?.listener?.didBackFromApplyDetail()
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
        
        handler.apply
            .bind { [weak self] apply in
                self?.thisApply = apply
            }
            .disposeOnDeactivate(interactor: self)
        
    }
    
    private func fetchApply(appyID: Int) {
        applyService.get(request: ApplyRequest(applyIds: appyID, includeContent: true)) { [weak self] result in
            switch result {
            case .success(let data):
                if let apply = data.applies.first(where: { $0.applyID == appyID }) {
                    self?.applyRelay.accept(apply)
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func didTapEditButton() {
        let bool = !showEditTypeTableViewRelay.value
        showEditTypeTableViewRelay.accept(bool)
    }
    
    private func didTapEditTypeCell(editTypeItem: EditTypeItem) {
        switch editTypeItem {
        case .apply:
            router?.attachEditApplyOverallRIB(apply: thisApply)
            didTapEditButton()
        case .stage:
            router?.attachEditApplyStageProgressRIB(apply: thisApply)
            didTapEditButton()
        case .delete:
            deleteApply(applyID: thisApply.applyID) { [weak self] in
                self?.listener?.didBackFromApplyDetail()
            }
        }
    }
    
    private func deleteApply(applyID: Int, completion: @escaping () -> Void) {
        applyService.delete(request: ApplyDeleteRequest(ids: applyID)) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(_):
                completion()
            }
        }
    }
    
    // MARK: 자식 RIBs으로 부터
    func didEditApplyStageProgress() {
        Log("[D] 에딧")
        router?.detachEditApplyStageProgressRIB()
        fetchApply(appyID: thisApply.applyID)
    }
    
    func didEditApplyOverall() {
        router?.detachEditApplyOverallRIB()
        fetchApply(appyID: thisApply.applyID)
    }
    
    func didTapBackButtonFromEditApplyOverallRIB() {
        router?.detachEditApplyOverallRIB()
    }
    
    func didTapBackButtonFromEditApplyStageProgressRIB() {
        router?.detachEditApplyStageProgressRIB()
    }
}

// MARK: PresentableHandler
extension ApplyDetailInteractor: ApplyDetailPresentableHandler {
    var apply: Observable<Apply> {
        return applyRelay.asObservable()
    }
    
    var showEditTypeTableView: Observable<Bool> {
        return showEditTypeTableViewRelay.asObservable()
    }
}
