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
        case setCompanySections([SearchSectionModel])
        case setJobTypeSections([SearchSectionModel])
        case setStageSections([StageSectionModel])
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
    }
    
    var initialState: ApplyWriteOverallPresentableState
    
    weak var router: ApplyWriteOverallRouting?
    weak var listener: ApplyWriteOverallListener?
    
    private let provider = Provider.shared
    
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
            return .empty()
        case let .textCompany(text):
            provider.api.company.search(queryRequest: .init(page: 1, size: 100), bodyRequest: .init(title: "삼", userDefined: true)).bind { i in
                print(i)
            }

            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setCompanySections(sections):
            newState.companySections = sections
        case let .setJobTypeSections(sections):
            newState.jobTypeSections = sections
        case let .setStageSections(sections):
            newState.stageSections = sections
        case .attach: break
        case .detach: break
        }
        
        return newState
    }
    
    private func makeSections(titles: [String]) -> [SearchSectionModel] {
        let searchItems = titles.map({ (title) -> SearchItem in
            SearchItem.result(ResultTableViewCellReator(state: .init(title: title, highlight: "")))
        })
        let searchSectionModel = SearchSectionModel(model: .search(searchItems), items: searchItems)
        
        return [searchSectionModel]
    }
    
    private func makeSections(stages: [Stage]) -> [StageSectionModel] {
        let stageItems = stages.map({ (stage) -> StageItem in
            StageItem.stage(StageCollectionViewCellReactor(state: .init(order: nil, stage: stage)))
        })
        let stageSectionModel = StageSectionModel(model: .stage(stageItems), items: stageItems)
        
        return [stageSectionModel]
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
