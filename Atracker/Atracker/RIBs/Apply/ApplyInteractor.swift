//
//  ApplyInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift
import RxCocoa

protocol ApplyRouting: ViewableRouting {
    func attachApplyDetailRIB(apply: Apply)
    func attachWriteApplyOverall()
    func attachMyPageRIB()
    func detachThisChildRIB()
    func reAttachApplyDetailRIB()
}

protocol ApplyPresentable: Presentable {
    var listener: ApplyPresentableListener? { get set }
    var action: ApplyPresentableAction? { get }
    var handler: ApplyPresentableHandler? { get set }
}

protocol ApplyListener: AnyObject {
//    func goBackToApplyRIB()
//    func goToApplyWriteRIB()
    func showTabBar()
    func hideTabBar()
    func didSignOut()
}

final class ApplyInteractor: PresentableInteractor<ApplyPresentable>, ApplyInteractable, ApplyPresentableListener {

    weak var router: ApplyRouting?
    weak var listener: ApplyListener?
    
    private let applyService: ApplyServiceProtocol
    
    private let appliesRelay = BehaviorRelay<[Apply]>(value: [])

    init(presenter: ApplyPresentable, applyService: ApplyServiceProtocol) {
        self.applyService = applyService
        
        super.init(presenter: presenter)
        
        presenter.listener = self
        presenter.handler = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        setupBind()
        fetchApplies()
    }

    override func willResignActive() {
        super.willResignActive()
        
        presenter.handler = nil
    }
    
    func setupBind() {
        
    }
    
    func fetchApplies() {
        applyService.get(request: ApplyRequest(applyIds: nil, includeContent: true)) { [weak self] result in
            switch result {
            case .success(let data):
                Log("[D] 지원 현황 가져오기 성공")
                self?.appliesRelay.accept(data.applies)
            case .failure(_):
                Log("[D] 지원 현황 가져오기 실패")
            }
        }
    }
    
    func didTabCell(apply: Apply) {
        router?.attachApplyDetailRIB(apply: apply)
    }
    
    func tapPlusButton() {
        listener?.hideTabBar()
        router?.attachWriteApplyOverall()
    }
    
    func reloadApplyList() {
        applyService.get(request: ApplyRequest(applyIds: nil, includeContent: true)) { [weak self] result in
            switch result {
            case .success(let data):
                Log("[D] 리로드 성공 \(data)")
            case .failure(let error):
                Log("[D] 리로드 실패 \(error)")
            }
            
        }
    }
    
    func tapMyPageButton() {
        router?.attachMyPageRIB()
    }

    // MARK: From Child RIB
    func tapBackButtonFromChildRIB() {
        router?.detachThisChildRIB()
        showTabBar()
    }
    
    func showTabBar() {
        listener?.showTabBar()
    }
    
    func hideTabBar() {
        listener?.hideTabBar()
    }
    
    func didSignOut() {
        Log("[SIGNOUT] start")
        listener?.didSignOut()
        Log("[SIGNOUT] end")
    }
}

extension ApplyInteractor: ApplyPresentableHandler {
    var applies: Observable<[Apply]> {
        return appliesRelay.asObservable()
    }
}
