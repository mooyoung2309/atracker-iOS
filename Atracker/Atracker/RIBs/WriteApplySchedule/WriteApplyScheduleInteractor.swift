//
//  WriteApplyScheduleInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs
import RxSwift
import RxCocoa

protocol WriteApplyScheduleRouting: ViewableRouting {
    func detachThisRIB()
}

protocol WriteApplySchedulePresentable: Presentable {
    var listener: WriteApplySchedulePresentableListener? { get set }
    
    var action: WriteApplySchedulePresentableAction? { get }
    var handler: WriteApplySchedulePresentableHandler? { get set }
}

protocol WriteApplyScheduleListener: AnyObject {
    func tapBackButtonFromChildRIB()
    func didWriteApply()
}

final class WriteApplyScheduleInteractor: PresentableInteractor<WriteApplySchedulePresentable>, WriteApplyScheduleInteractable, WriteApplySchedulePresentableListener {
    
    weak var router: WriteApplyScheduleRouting?
    weak var listener: WriteApplyScheduleListener?
    
    private let applyService: ApplyServiceProtocol
    private var applyCreateRequest: ApplyCreateRequest
    
    private let dateRelay = BehaviorRelay(value: Date())
    private let applyCreateStagesRelay = BehaviorRelay<[ApplyCreateStage]>(value: [])
    
    init(presenter: WriteApplySchedulePresentable, applyService: ApplyServiceProtocol, applyCreateRequest: ApplyCreateRequest) {
        self.applyService = applyService
        self.applyCreateRequest = applyCreateRequest
        
        super.init(presenter: presenter)
        
        presenter.listener = self
        presenter.handler = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        setupBind()
        self.applyService.get(request: ApplyRequest(applyIds: nil, includeContent: false)) { [weak self] result in
            switch result {
            case .success(let data):
                Log("[D] \(data)")
            case .failure(let error):
                Log("[D] \(error)")
            }
        }
    }
    
    override func willResignActive() {
        super.willResignActive()
        
        presenter.handler = nil
    }
    
    func setupBind() {
        guard let action = presenter.action else { return }
        
        action.tapBackButton
            .bind { [weak self] _ in
                self?.router?.detachThisRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.scrollCalendar
            .bind { [weak self] i in
                guard let this = self else { return }
                var date = this.dateRelay.value
                
                if i == 1 {
                    date = date.plusPeriod(.month, interval: 1)
                } else if i == -1 {
                    date = date.plusPeriod(.month, interval: -1)
                }
                self?.dateRelay.accept(date)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.changedApplyCreateStages
            .bind { [weak self] applyCreateStages in
                self?.applyCreateRequest.stages = applyCreateStages
                Log("[D] 리퀘스트 변경됨 \(self?.applyCreateRequest)")
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapNextButton
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.postApply(applyCreateRequest: this.applyCreateRequest) {
                    self?.listener?.didWriteApply()
                }
            }
            .disposeOnDeactivate(interactor: self)
        
        applyCreateStagesRelay.accept(applyCreateRequest.stages)
    }
    
    func postApply(applyCreateRequest: ApplyCreateRequest, completion: @escaping () -> Void) {
        applyService.post(request: applyCreateRequest) { [weak self] result in
            switch result {
            case .success():
                completion()
            case .failure(let error):
                completion()
            }
        }
    }
}

extension WriteApplyScheduleInteractor: WriteApplySchedulePresentableHandler {
    var date: Observable<Date> {
        return dateRelay.asObservable()
    }
    
    var applyCreateStages: Observable<[ApplyCreateStage]> {
        return applyCreateStagesRelay.asObservable()
    }
}
