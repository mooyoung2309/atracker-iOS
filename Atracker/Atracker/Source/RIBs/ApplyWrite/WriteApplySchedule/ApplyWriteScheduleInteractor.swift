//
//  WriteApplyScheduleInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs
import RxSwift
import RxCocoa
import ReactorKit

protocol ApplyWriteScheduleRouting: ViewableRouting {
    func detach()
}

protocol ApplyWriteSchedulePresentable: Presentable {
    var listener: ApplyWriteSchedulePresentableListener? { get set }
    
//    var action: WriteApplySchedulePresentableAction? { get }
//    var handler: WriteApplySchedulePresentableHandler? { get set }
}

protocol ApplyWriteScheduleListener: AnyObject {
    func didTapBackButtonFromWriteApplyScheduleRIB()
    func didApplyWrite()
}

final class ApplyWriteScheduleInteractor: PresentableInteractor<ApplyWriteSchedulePresentable>, ApplyWriteScheduleInteractable, ApplyWriteSchedulePresentableListener, Reactor {
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setSections
    }

    struct State {
        var company: Company
        var jobPosition: String
        var jobType: JobType
        var stages: [Stage]
    }
    
    weak var router: ApplyWriteScheduleRouting?
    weak var listener: ApplyWriteScheduleListener?
    
    var initialState: State
    
    private let applyService: ApplyServiceProtocolISOLDCODE
//    private let thisStages: [Stage]
//    private var applyCreateRequest: ApplyCreateRequest
    
    
//    private let dateRelay = BehaviorRelay(value: Date())
//    private let applyCreateStagesRelay = BehaviorRelay<[ApplyCreateStage]>(value: [])
    
    init(presenter: ApplyWriteSchedulePresentable,
         applyService: ApplyServiceProtocolISOLDCODE,
         company: Company,
         jobPosition: String,
         jobType: JobType,
         stages: [Stage]) {
        self.applyService = applyService
//        self.applyCreateRequest = applyCreateRequest
//        self.thisStages = stages
        
        self.initialState = State(company: company, jobPosition: jobPosition, jobType: jobType, stages: stages)
        
        super.init(presenter: presenter)
        
        presenter.listener = self
//        presenter.handler = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
//        setupBind()
//        self.applyService.get(request: ApplyRequest(applyIds: nil, includeContent: false)) { [weak self] result in
//            switch result {
//            case .success(let data):
//                Log("[D] \(data)")
//            case .failure(let error):
//                Log("[D] \(error)")
//            }
//        }
    }
    
    override func willResignActive() {
        super.willResignActive()
        
//        presenter.handler = nil
    }
    
    func sendAction(_ action: Action) {
        self.action.on(.next(action))
    }
    
//    func setupBind() {
//        guard let action = presenter.action else { return }
//
//        action.tapBackButton
//            .bind { [weak self] _ in
//                self?.router?.detachThisRIB()
//            }
//            .disposeOnDeactivate(interactor: self)
//
//        action.scrollCalendar
//            .bind { [weak self] i in
//                guard let this = self else { return }
//                var date = this.dateRelay.value
//
//                if i == 1 {
//                    date = date.plusPeriod(.month, interval: 1)
//                } else if i == -1 {
//                    date = date.plusPeriod(.month, interval: -1)
//                }
//                self?.dateRelay.accept(date)
//            }
//            .disposeOnDeactivate(interactor: self)
//
//        action.changedApplyCreateStages
//            .bind { [weak self] applyCreateStages in
//                self?.applyCreateRequest.stages = applyCreateStages
//                Log("[D] 리퀘스트 변경됨 \(self?.applyCreateRequest)")
//            }
//            .disposeOnDeactivate(interactor: self)
//
//        action.tapNextButton
//            .bind { [weak self] _ in
//                guard let this = self else { return }
//                this.postApply(applyCreateRequest: this.applyCreateRequest) {
//                    self?.listener?.didWriteApply()
//                }
//            }
//            .disposeOnDeactivate(interactor: self)
//
//        applyCreateStagesRelay.accept(applyCreateRequest.stages)
//    }
//
//    func postApply(applyCreateRequest: ApplyCreateRequest, completion: @escaping () -> Void) {
//        applyService.post(request: applyCreateRequest) { [weak self] result in
//            switch result {
//            case .success():
//                completion()
//            case .failure(let error):
//                completion()
//            }
//        }
//    }
}
