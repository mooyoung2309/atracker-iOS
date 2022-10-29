//
//  ApplyWriteInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift
import RxCocoa
import ReactorKit

protocol ApplyWriteOverallRouting: ViewableRouting {
    func attachWriteApplyScheduleRIB(applyCreateRequest: ApplyCreateRequest, stages: [Stage])
    func detachWriteApplyScheduleRIB()
}

protocol ApplyWriteOverallPresentable: Presentable {
    var listener: ApplyWriteOverallPresentableListener? { get set }
}

protocol ApplyWriteOverallListener: AnyObject {
    func didWriteApply()
    func detachApplyWriteOverallRIB()
}

final class ApplyWriteOverallInteractor: PresentableInteractor<ApplyWriteOverallPresentable>, ApplyWriteOverallInteractable, ApplyWriteOverallPresentableListener, Reactor {
    
    typealias Action = ApplyWriteOverallPresentableAction
    typealias State = ApplyWriteOverallPresentableState
    
    enum Mutation {
        case setCompanySearchSections([CompanySearchSectionModel])
        case setJobTypeSearchSections([JobTypeSearchSectionModel])
        case setStageSearchSections([StageSearchSectionModel])
        case updateStageSearchSection(IndexPath, StageSearchItem)
        case updateCompanyText(String)
        case updateJobPositionText(String)
        case updateSelectedCompany(Company)
        case updateSelectedJobType(JobType)
        case updateSelectedStages([Stage])
        case updateIsHiddenCompany(Bool)
        case updateIsHiddenJobType(Bool)
        //        case fetchCompanies([Company])
        //        case fetchJobTypes([JobType])
        //        case fetchStages([Stage])
        //        case updateCompany(Company)
        //        case updateStages(Stage)
        //        case updateJobType(JobType)
        //        case updateJobPosition(String)
        //        case showCompanyTableView(Bool?)
        //        case showJobTypeTableView(Bool?)
        case detach
        case attach
        case none
    }
    
    var initialState: ApplyWriteOverallPresentableState
    
    weak var router: ApplyWriteOverallRouting?
    weak var listener: ApplyWriteOverallListener?
    
    private let provider = ServiceProvider.shared
    
    override init(presenter: ApplyWriteOverallPresentable) {
        self.initialState = .init()
        
        super.init(presenter: presenter)
        
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh: return mutateRefresh()
        case let .textCompany(text): return mutateTextCompany(text)
        case let .textJobPosition(text): return mutateTextJobPosition(text)
        case .toggleJobType: return mutateToggleJobType()
        case let .selectCompany(indexPath): return mutateSelectCompany(indexPath)
        case let .selectJobType(indexPath): return mutateSelectJobType(indexPath)
        case let .selectStage(indexPath): return mutateSelectStage(indexPath)
        case .tapBackButton: return .just(.detach)
        case .tapNextButton: return .just(.attach)
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return mutation.flatMap { [weak self] mutation -> Observable<Mutation> in
            guard let `self` = self else { return .empty() }
            
            switch mutation {
            case .attach: return self.attachWriteApplyScheduleRIBTransform()
            case .detach: return self.detachApplyWriteOverallRIBTransform()
            default: return .just(mutation)
            }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setCompanySearchSections(sections):
            newState.companySections = sections
        case let .setJobTypeSearchSections(sections):
            newState.jobTypeSections = sections
        case let .setStageSearchSections(sections):
            newState.stageSections = sections
        case let .updateStageSearchSection(indexPath, stageSearchItem):
            newState.stageSections[indexPath.section].items[indexPath.row] = stageSearchItem
        case let .updateCompanyText(text):
            newState.companyText = text
        case let .updateJobPositionText(text):
            newState.jobPositionText = text
        case let .updateSelectedCompany(company):
            newState.selectedCompany = company
            newState.companyText = company.name
        case let .updateSelectedJobType(jobType):
            newState.selectedJobType = jobType
        case let .updateSelectedStages(stages):
            newState.selectedStages = stages
        case let .updateIsHiddenCompany(bool):
            newState.isHiddenCompany = bool
        case let .updateIsHiddenJobType(bool):
            newState.isHiddenJobType = bool
        case .attach: break
        case .detach: break
        case .none: break
        }
        
        return newState
    }
    
    private func mutateRefresh() -> Observable<Mutation> {
        let setJobTypeSections: Observable<Mutation> = .just(.setJobTypeSearchSections(makeSections(jobTypes: JobType.elements)))
        let setStageSections: Observable<Mutation> = provider.stageService.get().map { [weak self] stages in
                .setStageSearchSections(self?.makeSections(stages: stages) ?? [])
        }
        
        return .concat([setJobTypeSections, setStageSections])
    }
    
    private func mutateTextCompany(_ text: String) -> Observable<Mutation> {
        let setCompanySections: Observable<Mutation> = provider.companyService.search(title: text, page: 1)
            .map { [weak self] in
                return .setCompanySearchSections(self?.makeSections(companyResponse: $0) ?? [])
            }
        let updateIsHiddenCompany: Observable<Mutation> = currentState.companyText == text ? .empty() : .just(.updateIsHiddenCompany(text.isEmpty))
        let updateIsHiddenJobType: Observable<Mutation> = .just(.updateIsHiddenJobType(true))
        let updateCompanyText: Observable<Mutation> = .just(.updateCompanyText(text))
        
        return .concat([setCompanySections, updateIsHiddenCompany, updateIsHiddenJobType, updateCompanyText])
    }
    
    private func mutateTextJobPosition(_ text: String) -> Observable<Mutation> {
        let updateJobPositionText: Observable<Mutation> = .just(.updateJobPositionText(text))
        let updateIsHiddenCompany: Observable<Mutation> = .just(.updateIsHiddenCompany(true))
        let updateIsHiddenJobType: Observable<Mutation> = .just(.updateIsHiddenJobType(true))
        
        return .concat([updateJobPositionText, updateIsHiddenCompany, updateIsHiddenJobType])
    }
    
    private func mutateToggleJobType() -> Observable<Mutation> {
        return .concat([.just(.updateIsHiddenJobType(!currentState.isHiddenJobType)),
                        .just(.updateIsHiddenCompany(true))])
    }
    
    private func mutateSelectCompany(_ indexPath: IndexPath) -> Observable<Mutation> {
        guard case let .result(reactor) = currentState.companySections[indexPath.section].items[indexPath.row] else { return .empty() }
        
        if let company = reactor.currentState {
            return .concat([.just(.updateSelectedCompany(company)), .just(.updateIsHiddenCompany(true)), .just(.updateIsHiddenJobType(true))])
        } else {
            let add: Observable<Mutation> =
            provider.companyService.add(name: currentState.companyText).map {
                if let company = $0.companies.first {
                    return .updateSelectedCompany(company)
                } else {
                    return .none
                }
            }
            return .concat([add, .just(.updateIsHiddenCompany(true)), .just(.updateIsHiddenJobType(true))])
        }
    }
    
    private func mutateSelectJobType(_ indexPath: IndexPath) -> Observable<Mutation> {
        guard case let .result(reactor) = currentState.jobTypeSections[indexPath.section].items[indexPath.row] else { return .empty() }
        
        return .concat([.just(.updateSelectedJobType(reactor.currentState)), .just(.updateIsHiddenJobType(true))])
    }
    
    private func mutateSelectStage(_ indexPath: IndexPath) -> Observable<Mutation> {
        guard case let .result(reactor) = currentState.stageSections[indexPath.section].items[indexPath.row] else { return .empty() }
        var selectedStages: [Stage] = currentState.selectedStages
        
        if selectedStages.contains(where: { $0.id == reactor.currentState.stage.id }) {
            selectedStages.removeAll(where: { $0.id == reactor.currentState.stage.id })
        } else {
            selectedStages.append(reactor.currentState.stage)
        }
        
        let items: [StageSearchItem] = currentState.stageSections.first?.items.map { (item) -> StageSearchItem in
            guard case let .result(reactor) = item else { return item }
            
            return StageSearchItem.result(StageSearchCollectionViewCellReactor(state: .init(order: selectedStages.firstIndex(where: {$0.id == reactor.currentState.stage.id }), stage: reactor.currentState.stage)))
        } ?? []
        
        let section: StageSearchSectionModel = .init(model: .search(items), items: items)
        
        return .concat([.just(.updateSelectedStages(selectedStages)), .just(.setStageSearchSections([section])), .just(.updateIsHiddenJobType(true)), .just(.updateIsHiddenCompany(true))])
    }
    
    private func makeApplyCreateRequest() -> ApplyCreateRequest? {
        guard let company = currentState.selectedCompany, let jobType = currentState.selectedJobType?.title else { return nil }
        let jobPosition = currentState.jobPositionText
        let stages: [ApplyCreateStage] = currentState.selectedStages.enumerated().map { (index, stage) -> ApplyCreateStage in
            return ApplyCreateStage(order: index, stageID: stage.id)
        }
        
        return ApplyCreateRequest(company: company, jobPosition: jobPosition, jobType: jobType, stages: stages)
    }
    
    private func makeSections(jobTypes: [JobType]) -> [JobTypeSearchSectionModel] {
        let items: [JobTypeSearchItem] = jobTypes.map({ (jobType) -> JobTypeSearchItem in
            JobTypeSearchItem.result(JobTypeSearchTableViewCellReactor(jobType: jobType))
        })
        let section = JobTypeSearchSectionModel.init(model: .search(items), items: items)
        
        return [section]
    }
    
    private func makeSections(companyResponse: CompanyResponse) -> [CompanySearchSectionModel] {
        var items: [CompanySearchItem] = companyResponse.contents.map({ (company) -> CompanySearchItem in
            CompanySearchItem.result(CompanySearchTableViewCellReactor(company: company))
        })
        items.append(CompanySearchItem.result(CompanySearchTableViewCellReactor(company: nil)))
        
        let section = CompanySearchSectionModel.init(model: .search(items), items: items)
        
        return [section]
    }
    
    private func makeSections(stages: [Stage]) -> [StageSearchSectionModel] {
        let items = stages.map({ (stage) -> StageSearchItem in
            StageSearchItem.result(StageSearchCollectionViewCellReactor(state: .init(order: nil, stage: stage)))
        })
        let section = StageSearchSectionModel.init(model: .search(items), items: items)
        
        return [section]
    }
    
    private func detachApplyWriteOverallRIBTransform() -> Observable<Mutation> {
        listener?.detachApplyWriteOverallRIB()
        
        return .empty()
    }
    
    private func attachWriteApplyScheduleRIBTransform() -> Observable<Mutation> {
        guard let applyCreateRequest = makeApplyCreateRequest() else { return .empty() }
        
        router?.attachWriteApplyScheduleRIB(applyCreateRequest: applyCreateRequest, stages: currentState.selectedStages)
        
        return .empty()
    }

    func didWriteApply() {
        listener?.didWriteApply()
    }
    
    // MARK: From Child RIBs
    func didTapBackButtonFromWriteApplyScheduleRIB() {
        router?.detachWriteApplyScheduleRIB()
    }
}
