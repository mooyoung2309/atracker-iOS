//
//  EditApplyOverallInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift
import RxCocoa

protocol EditApplyOverallRouting: ViewableRouting {
    
}

protocol EditApplyOverallPresentable: Presentable {
    var listener: EditApplyOverallPresentableListener? { get set }
    var action: EditApplyOverallPresentableAction? { get }
    var handler: EditApplyOverallPresentableHandler? { get set }
}

protocol EditApplyOverallListener: AnyObject {
    func didTapBackButtonFromEditApplyOverallRIB()
    func didEditApplyOverall()
}

final class EditApplyOverallInteractor: PresentableInteractor<EditApplyOverallPresentable>, EditApplyOverallInteractable, EditApplyOverallPresentableListener {
    
    weak var router: EditApplyOverallRouting?
    weak var listener: EditApplyOverallListener?
    
    private let applyService: ApplyServiceProtocol
    private let companyService: CompanyServiceProtocol
    private let apply: Apply
    private var applyUpdateRequest: ApplyUpdateRequest?
    
    private lazy var companyRelay = BehaviorRelay<Company>(value: Company(id: apply.companyID, name: apply.companyName))
    private lazy var jobPositionRelay = BehaviorRelay<String>(value: apply.jobPosition)
    private lazy var jobTypeRelay = BehaviorRelay<JobType>(value: JobType.toJobType(title: apply.jobType))
    private lazy var stageProgressRelay = BehaviorRelay<[StageProgress]>(value: apply.stageProgress)
    private lazy var showCompanyTableViewRelay = PublishRelay<[Company]>()
    private lazy var hideCompanyTableViewRelay = PublishRelay<Void>()
    private lazy var toggleJobTypeTableViewRealy = PublishRelay<Void>()
    private lazy var hideJobTypeTableViewRelay = PublishRelay<Void>()
    
    private var companies: [Company] = []
    private var prevCompanyName = ""
    private var searchCompanyPage = 1
    
    init(presenter: EditApplyOverallPresentable, applyService: ApplyServiceProtocol, companyService: CompanyServiceProtocol, apply: Apply) {
        self.applyService = applyService
        self.companyService = companyService
        self.apply = apply
        
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
        
        action.tapBackButton
            .bind { [weak self] in
                self?.listener?.didTapBackButtonFromEditApplyOverallRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapNextButton
            .bind { [weak self] in
                self?.sendApplyUpdateRequest() {
                    self?.listener?.didEditApplyOverall()
                }
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapAddCompanyCell
            .bind { [weak self] companyName in
                self?.addCompany(companyName: companyName)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapCompanyCell
            .bind { [weak self] company in
                self?.companyRelay.accept(company)
                self?.hideCompanyTableViewRelay.accept(())
            }
            .disposeOnDeactivate(interactor: self)
        
        action.textCompanyName
            .bind { [weak self] companyName in
                if !companyName.isEmpty {
                    self?.searchCompany(companyName: companyName)
                } else {
                    self?.hideCompanyTableViewRelay.accept(())
                }
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapJobType
            .bind { [weak self] in
                self?.toggleJobTypeTableViewRealy.accept(())
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapJobTypeCell
            .bind { [weak self] jobType in
                self?.jobTypeRelay.accept(jobType)
                self?.hideJobTypeTableViewRelay.accept(())
            }
            .disposeOnDeactivate(interactor: self)
        
        action.changedStageProgresses
            .bind { [weak self] stageProgresses in
                self?.stageProgressRelay.accept(stageProgresses)
            }
            .disposeOnDeactivate(interactor: self)
        
        Observable.combineLatest(handler.company, handler.jobPosition, handler.jobType, handler.stageProgresses)
            .bind { [weak self] company, jobPosition, jobType, stageProgresses in
                guard let this = self else { return }
                
                var updateStages: [UpdateStage] = []
                for (index, stageProgress) in stageProgresses.enumerated() {
                    updateStages.append(UpdateStage(eventAt: Date().getISO8601String(), order: index, stageID: stageProgress.stageID))
                }
                this.applyUpdateRequest = ApplyUpdateRequest(applyID: this.apply.applyID, company: company, jobPosition: jobPosition, jobType: jobType.code, stages: updateStages)
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private func sendApplyUpdateRequest(completion: @escaping () -> Void) {
        if let applyUpdateRequest = applyUpdateRequest {
            applyService.put(request: applyUpdateRequest) { [weak self] result in
                switch result {
                case .success(let bool):
                    Log("[D] 지원 후기 수정하기 성공")
                    completion()
                case .failure(let error):
                    Log("[D] 지원 후기 수정하기 실패")
                    completion()
                }
            }
        }
        
    }
    
    private func searchCompany(companyName: String) {
        if prevCompanyName == companyName {
            searchCompanyPage += 1
        } else {
            searchCompanyPage = 1
            companies.removeAll()
        }
        
        companyService.search(title: companyName, page: searchCompanyPage) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.companies.append(contentsOf: data.contents)
                this.showCompanyTableViewRelay.accept(this.companies)
                return
            case  .failure(_):
                return
            }
        }
    }
    
    private func addCompany(companyName: String) {
        companyService.add(name: companyName) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                Log("[D] 회사 추가 성공 \(data.companies)")
                self?.hideCompanyTableViewRelay.accept(())
                if let company = data.companies.first {
                    self?.companyRelay.accept(company)
                }
                return
            case .failure(let error):
                Log("[D] 회사 추가 실패 \(error)")
                return
            }
        }
    }
}

extension EditApplyOverallInteractor: EditApplyOverallPresentableHandler {
    var company: Observable<Company> {
        return companyRelay.asObservable()
    }
    
    var jobPosition: Observable<String> {
        return jobPositionRelay.asObservable()
    }
    
    var jobType: Observable<JobType> {
        return jobTypeRelay.asObservable()
    }
    
    var stageProgresses: Observable<[StageProgress]> {
        return stageProgressRelay.asObservable()
    }
    
    var showCompanyTableView: Observable<[Company]> {
        return showCompanyTableViewRelay.asObservable()
    }
    
    var hideCompanyTableView: Observable<Void> {
        return hideCompanyTableViewRelay.asObservable()
    }
    var toggleJobTypeTableView: Observable<Void> {
        return toggleJobTypeTableViewRealy.asObservable()
    }
    
    var hideJobTypeTableView: Observable<Void> {
        return hideJobTypeTableViewRelay.asObservable()
    }
}
