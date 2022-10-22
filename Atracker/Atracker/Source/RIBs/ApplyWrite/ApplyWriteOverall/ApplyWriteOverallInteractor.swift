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
        case .refresh:
            return mutateRefresh()
        case let .textCompany(text):
            return mutateTextCompany(text)
        case let .textJobPosition(text):
            return mutateTextJobPosition(text)
        case .toggleJobType:
            return mutateToggleJobType()
        case let .selectCompany(indexPath):
            return mutateSelectCompany(indexPath)
        case let .selectJobType(indexPath):
            return mutateSelectJobType(indexPath)
        case let .selectStage(indexPath):
            return mutateSelectStage(indexPath)
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
        let updateIsHiddenCompany: Observable<Mutation> = .just(.updateIsHiddenCompany(text.isEmpty))
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
            let add: Observable<Mutation> = provider.companyService.add(name: currentState.companyText).map {
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
    
//    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
//        return mutation
//            .flatMap { [weak self] mutation -> Observable<Mutation> in
//                guard let this = self else { return .empty() }
//                switch mutation {
//                case .detach:
//                    return this.detachApplyWriteOverallRIBTransform()
//                case .attach:
//                    guard let company = this.currentState.updatedCompany else { break }
//                    guard let jobPosition = this.currentState.updatedJobPosition else { break }
//                    guard let jobType = this.currentState.updatedJobType else { break }
//                    let stages = this.currentState.updatedStages
//                    guard stages.count != 0  else { break }
//                    let applyCreateStages = this.currentState.updatedStages.enumerated().map { (index, element) in return ApplyCreateStage(eventAt: nil, order: index, stageID: element.id)
//                    }
//                    let applyCreateRequest = ApplyCreateRequest(company: company, jobPosition: jobPosition, jobType: jobType.code, stages: applyCreateStages)
//
//                    return this.attachWriteApplyScheduleRIBTransform(applyCreateRequest: applyCreateRequest, stages: stages)
//                default:
//                    return .just(mutation)
//                }
//                return .empty()
//            }
//    }
    
//    func reduce(state: ApplyWriteOverallPresentableState, mutation: Mutation) -> ApplyWriteOverallPresentableState {
//        var newState = state
//        switch mutation {
//        case .fetchCompanies(let companies):
//            newState.companies = companies
//        case .fetchStages(let stages):
//            newState.stages = stages
//        case .fetchJobTypes(let jobTypes):
//            newState.jobTypes = jobTypes
//        case .updateCompany(let company):
//            newState.updatedCompany = company
//        case .updateStages(let stage):
//            if newState.updatedStages.contains(where: { $0.id == stage.id }) {
//                newState.updatedStages.removeAll(where: { $0.id == stage.id })
//            } else {
//                newState.updatedStages.append(stage)
//            }
//        case .updateJobType(let jobType):
//            newState.updatedJobType = jobType
//        case .updateJobPosition(let jobPosition):
//            newState.updatedJobPosition = jobPosition
//        case .showCompanyTableView(let bool):
//            if let bool = bool {
//                newState.showCompanyTableView = bool
//            } else {
//                newState.showCompanyTableView.toggle()
//            }
//        case .showJobTypeTableView(let bool):
//            if let bool = bool {
//                newState.showJobTypeTableView = bool
//            } else {
//                newState.showJobTypeTableView.toggle()
//            }
//        case .detach: break
//        case .attach: break
//        }
//        return newState
//    }
    
    private func detachApplyWriteOverallRIBTransform() -> Observable<Mutation> {
        listener?.detachApplyWriteOverallRIB()
        return .empty()
    }
    
    private func attachWriteApplyScheduleRIBTransform(applyCreateRequest: ApplyCreateRequest, stages: [Stage]) -> Observable<Mutation> {
        router?.attachWriteApplyScheduleRIB(applyCreateRequest: applyCreateRequest, stages: stages)
        return .empty()
    }
    
//    func searchCompany(companyName: String) {
//        if prevCompanyName == companyName {
//            searchCompanyPage += 1
//        } else {
//            searchCompanyPage = 1
//            tmpCompanies.removeAll()
//        }
//
//        companyService.search(title: companyName, page: searchCompanyPage) { [weak self] result in
//            guard let this = self else { return }
//            switch result {
//            case .success(let data):
//                this.tmpCompanies.append(contentsOf: data.contents)
//                this.companiesRelay.accept(this.tmpCompanies)
//                return
//            case  .failure(_):
//                return
//            }
//        }
//    }
    
//    func addCompany(companyName: String) {
//        companyService.add(name: companyName) { [weak self] result in
//            guard let this = self else { return }
//            switch result {
//            case .success(let data):
//                Log("[D] 회사 추가 성공 \(data.companies)")
//                return
//            case .failure(let error):
//                Log("[D] 회사 추가 실패 \(error)")
//                return
//            }
//        }
//    }
    
//    func fetchStages() {
//        stageService.get { [weak self] result in
//            switch result {
    //            caseet d != nilata):
//                self?.stagesRelay.accept(data)
//                return
//            case .failure(_):
//                return
//            }
//        }
//    }
    
    func didWriteApply() {
        listener?.didWriteApply()
    }
    
    // MARK: From Child RIBs
    func didTapBackButtonFromWriteApplyScheduleRIB() {
        router?.detachWriteApplyScheduleRIB()
    }
}

//extension ApplyWriteOverallInteractor: ApplyWriteOverallPresentableHandler {
//    var companies: Observable<[Company]> {
//        return companiesRelay.asObservable()
//    }
//
//    var stages: Observable<[Stage]> {
//        return stagesRelay.asObservable()
//    }
//
//    var isShowCompanyTableView: Observable<Bool> {
//        return isShowCompanyTableViewRelay.asObservable()
//    }
//
//    var isShowJobTypeTableView: Observable<Bool> {
//        return isShowJobTypeTableViewRelay.asObservable()
//    }
//}
