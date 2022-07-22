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
    func detachThisChildRIB()
    func detachWriteApplyOverallRIB()
    func detachApplyDetailRIB()
}

protocol ApplyPresentable: Presentable {
    var listener: ApplyPresentableListener? { get set }
    var action: ApplyPresentableAction? { get }
    var handler: ApplyPresentableHandler? { get set }
}

protocol ApplyListener: AnyObject {
    func didSignOut()
}

final class ApplyInteractor: PresentableInteractor<ApplyPresentable>, ApplyInteractable, ApplyPresentableListener {
    
    weak var router: ApplyRouting?
    weak var listener: ApplyListener?
    
    private let applyService: ApplyServiceProtocol
    private let userService: UserServiceProtocol
    
    private let appliesRelay = BehaviorRelay<[Apply]>(value: [])
    private let myPageRelay = PublishRelay<MyPageResponse>()

    init(presenter: ApplyPresentable, applyService: ApplyServiceProtocol, userService: UserServiceProtocol) {
        self.applyService = applyService
        self.userService = userService
        
        super.init(presenter: presenter)
        
        presenter.listener = self
        presenter.handler = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        setupBind()
        fetchApplies()
        fetchMyPage()
    }

    override func willResignActive() {
        super.willResignActive()
        
        presenter.handler = nil
    }
    
    func setupBind() {
        guard let action = presenter.action else { return }
        
        action.tapApplyTVC
            .bind { [weak self] apply in
                self?.router?.attachApplyDetailRIB(apply: apply)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapPlusButton
            .bind { [weak self] _ in
                self?.router?.attachWriteApplyOverall()
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    func fetchApplies() {
        applyService.get(request: ApplyRequest(applyIds: nil, includeContent: true)) { [weak self] result in
            switch result {
            case .success(let data):
                Log("[D] 지원 현황 가져오기 성공\n\(data.applies)")
                self?.appliesRelay.accept(data.applies)
            case .failure(_):
                Log("[D] 지원 현황 가져오기 실패")
            }
        }
    }
    
    func fetchMyPage() {
        userService.myPage { [weak self] result in
            switch result {
            case .success(let data):
                Log("[D] 마이페이지 가져오기 성공 \(data)")
                self?.myPageRelay.accept(data)
            case .failure(let error):
                Log("[D] 마이페이지 가져오기 실패 \(error)")
            }
        }
    }
    
    // MARK: From Child RIB
    
    func didSignOut() {
        listener?.didSignOut()
    }
    
    func didWriteApply() {
        router?.detachWriteApplyOverallRIB()
        fetchApplies()
    }
    
    func didBackFromApplyDetail() {
        router?.detachApplyDetailRIB()
        fetchApplies()
    }
}

extension ApplyInteractor: ApplyPresentableHandler {
    var applies: Observable<[Apply]> {
        return appliesRelay.asObservable()
    }
    
    var myPage: Observable<MyPageResponse> {
        return myPageRelay.asObservable()
    }
}
