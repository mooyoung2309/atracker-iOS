//
//  ApplyWriteInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift
import RxCocoa

protocol WriteApplyOverallRouting: ViewableRouting {
    func attachWriteApplyScheduleRIB(applyCreateRequest: ApplyCreateRequest)
    func detachThisChildRIB()
    func testBackButton()
}

protocol WriteApplyOverallPresentable: Presentable {
    var listener: WriteApplyOverallPresentableListener? { get set }
    var action: WriteApplyOverallPresentableAction? { get }
    var handler: WriteApplyOverallPresentableHandler? { get set }
}

protocol WriteApplyOverallListener: AnyObject {
    func didWriteApply()
}

final class WriteApplyOverallInteractor: PresentableInteractor<WriteApplyOverallPresentable>, WriteApplyOverallInteractable, WriteApplyOverallPresentableListener {
    
    weak var router: WriteApplyOverallRouting?
    weak var listener: WriteApplyOverallListener?
    
    private let applyService: ApplyServiceProtocol
    private let companyService: CompanyServiceProtocol
    private let stageService: StageServiceProtocol
    
    private let companiesRelay = PublishRelay<[Company]>()
    private let stagesRelay = PublishRelay<[Stage]>()
    private let isShowCompanyTableViewRelay = PublishRelay<Bool>()
    private let isShowJobTypeTableViewRelay = BehaviorRelay<Bool>(value: false)
    
    private var tmpCompanies: [Company] = []
    private var prevCompanyName = ""
    private var searchCompanyPage = 1
    
    private var applyCreateRequest: ApplyCreateRequest?
    private var disposBag = DisposeBag()
    
    init(presenter: WriteApplyOverallPresentable, applyService: ApplyServiceProtocol, companyService: CompanyServiceProtocol, stageService: StageServiceProtocol) {
        self.applyService = applyService
        self.companyService = companyService
        self.stageService = stageService
        
        super.init(presenter: presenter)
        
        presenter.listener = self
        presenter.handler = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        setupBind()
        fetchStages()
    }
    
    override func willResignActive() {
        super.willResignActive()
        presenter.handler = nil
    }
    
    func setupBind() {
        guard let action = presenter.action else { return }
        
        action.tapBackButton
            .bind { [weak self] in
                self?.router?.testBackButton()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapNextButton
            .bind { [weak self] in
                guard let this = self else { return }
                if let applyCreateRequest = this.applyCreateRequest {
                    this.router?.attachWriteApplyScheduleRIB(applyCreateRequest: applyCreateRequest)
                }
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapJobTypeButton
            .bind { [weak self] in
                guard let this = self else { return }
                if this.isShowJobTypeTableViewRelay.value {
                    this.isShowJobTypeTableViewRelay.accept(false)
                } else {
                    this.isShowJobTypeTableViewRelay.accept(true)
                }
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapAddCompanyButton
            .bind { [weak self] companyName in
                self?.addCompany(companyName: companyName)
                self?.isShowCompanyTableViewRelay.accept(false)
                self?.isShowJobTypeTableViewRelay.accept(false)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.textCompanyName
            .bind { [weak self] companyName in
                if companyName != "" && companyName != self?.prevCompanyName {
                    self?.searchCompany(companyName: companyName)
                    self?.isShowCompanyTableViewRelay.accept(true)
                } else if companyName == "" {
                    self?.isShowCompanyTableViewRelay.accept(false)
                }
            }
            .disposeOnDeactivate(interactor: self)
        
        action.textPositionName
            .bind { [weak self] positionName in
                self?.isShowCompanyTableViewRelay.accept(false)
                self?.isShowJobTypeTableViewRelay.accept(false)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.textJobTypeName
            .bind { [weak self] jobTypeName in
                self?.isShowJobTypeTableViewRelay.accept(false)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.selectedCompany
            .bind { [weak self] _ in
                self?.isShowCompanyTableViewRelay.accept(false)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.selectedStages
            .bind { [weak self] _ in
                self?.isShowCompanyTableViewRelay.accept(false)
                self?.isShowJobTypeTableViewRelay.accept(false)
            }
            .disposeOnDeactivate(interactor: self)
        
        Observable.combineLatest(action.selectedCompany, action.textPositionName, action.textJobTypeName, action.selectedStages).bind { [weak self] company, position, jobType, stages in
            
            var applyCreateStages: [ApplyCreateStage] = []
            for (i, stage) in stages.enumerated() {
                let applyCreateStage = ApplyCreateStage(eventAt: nil, order: i, stageID: stage.id)
                applyCreateStages.append(applyCreateStage)
            }
            
            self?.applyCreateRequest = ApplyCreateRequest(company: company, jobPosition: position, jobType: "INTERN", stages: applyCreateStages)
            
            Log("[D] 리퀘스트 변경됨 \(self?.applyCreateRequest)")
        }
        .disposeOnDeactivate(interactor: self)
    }
    
    func searchCompany(companyName: String) {
        if prevCompanyName == companyName {
            searchCompanyPage += 1
        } else {
            searchCompanyPage = 1
            tmpCompanies.removeAll()
        }
        
        companyService.search(title: companyName, page: searchCompanyPage) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                this.tmpCompanies.append(contentsOf: data.contents)
                this.companiesRelay.accept(this.tmpCompanies)
                return
            case  .failure(_):
                return
            }
        }
    }
    
    func addCompany(companyName: String) {
        companyService.add(name: companyName) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                Log("[D] 회사 추가 성공 \(data.companies)")
                return
            case .failure(let error):
                Log("[D] 회사 추가 실패 \(error)")
                return
            }
        }
    }
    
    func fetchStages() {
        stageService.get { [weak self] result in
            switch result {
            case .success(let data):
                self?.stagesRelay.accept(data)
                return
            case .failure(_):
                return
            }
        }
    }
    
    func didWriteApply() {
        listener?.didWriteApply()
    }
    
    // MARK: From Child RIBs
    func tapBackButtonFromChildRIB() {
        router?.detachThisChildRIB()
    }
}

extension WriteApplyOverallInteractor: WriteApplyOverallPresentableHandler {
    var companies: Observable<[Company]> {
        return companiesRelay.asObservable()
    }
    
    var stages: Observable<[Stage]> {
        return stagesRelay.asObservable()
    }
    
    var isShowCompanyTableView: Observable<Bool> {
        return isShowCompanyTableViewRelay.asObservable()
    }
    
    var isShowJobTypeTableView: Observable<Bool> {
        return isShowJobTypeTableViewRelay.asObservable()
    }
}
