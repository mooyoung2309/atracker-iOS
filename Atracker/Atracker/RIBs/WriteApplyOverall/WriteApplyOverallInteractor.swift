//
//  ApplyWriteInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift

protocol WriteApplyOverallRouting: ViewableRouting {
    func attachWriteApplyScheduleRIB()
//    func detachWriteApplyScheduleRIB()
    func detachThisChildRIB()
}

protocol WriteApplyOverallPresentable: Presentable {
    var listener: WriteApplyOverallPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setupNavigaionBar()
    func resetCollectionView()
    func reloadCompanySearchTableView(companies: [Company])
    func showCompanySearchTableView()
    func hideCompanySearchTableView()
    func selectCompanySearchButton()
    func unSelectCompanySearchButton()
    func switchJobTypeSearchTableView()
    func updateCompanyLabel(text: String)
    func updateJobTypeLabel(text: String)
    func updateStageCollectionView(stages: [Stage])
}

protocol WriteApplyOverallListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
//    func goBackToApplyRIB()
//    func goBackToWriteApplyOverallRIB()
    func tapBackButtonFromChildRIB()
    func showTabBar()
    func hideTabBar()
}

final class WriteApplyOverallInteractor: PresentableInteractor<WriteApplyOverallPresentable>, WriteApplyOverallInteractable, WriteApplyOverallPresentableListener {
    
    weak var router: WriteApplyOverallRouting?
    weak var listener: WriteApplyOverallListener?
    
    private let companyService: CompanyServiceProtocol
    private let stageService: StageServiceProtocol
    
    private var companies: [Company] = []
    private var selectedCompany: Company?
    private var companyName = ""
    private var companyPage = 1

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: WriteApplyOverallPresentable, companyService: CompanyServiceProtocol, stageService: StageServiceProtocol) {
        self.companyService = companyService
        self.stageService = stageService
        
        super.init(presenter: presenter)
        
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        refreshStage()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func tapBackButton() {
        listener?.showTabBar()
        listener?.tapBackButtonFromChildRIB()
    }
    
    func tapNextButton() {
        router?.attachWriteApplyScheduleRIB()
    }
    
    func tapResetButton() {
        presenter.resetCollectionView()
    }
    
    func tapJobTypeSearchButton() {
        presenter.switchJobTypeSearchTableView()
    }
    
    func tapJobTypeTableView(text: String) {
        presenter.updateJobTypeLabel(text: text)
        presenter.switchJobTypeSearchTableView()
    }
    
    func searchCompanyName(text: String? = nil) {
        var companName = ""
        
        if let text = text {
            companName = text
        } else {
            companName = self.companyName
        }
        
        if companName.isEmpty {
            presenter.hideCompanySearchTableView()
            presenter.unSelectCompanySearchButton()
        } else {
            searchCompany(companyName: companName)
        }
    }
    
    func tapCompanySearchButton() {
        
    }
    
    func tapCompanyTableView(company: Company) {
        Log("[D] 회사 테이블 뷰 탭")
        presenter.updateCompanyLabel(text: company.name)
        presenter.hideCompanySearchTableView()
    }
    
    func tapPlusCompay() {
        companyService.add(name: self.companyName) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                Log("[D] 회사 추가 성공 \(data.companies)")
//                data.companies.first
                return
            case .failure(let error):
                Log("[D] 회사 추가 실패 \(error)")
                return
            }
        }
        presenter.hideCompanySearchTableView()
    }
    
    func refreshStage() {
        stageService.get { [weak self] result in
            switch result {
            case .success(let data):
                Log("[D] 스테이지 얻기 성공 \(data)")
                self?.presenter.updateStageCollectionView(stages: data)
                return
            case .failure(let error):
                Log("[D] 스테이지 얻기 실패")
                return
            }
            
        }
    }
    
    // MARK: Private
    private func searchCompany(companyName: String) {
        if self.companyName == companyName {
            companyPage += 1
        } else {
            companyPage = 1
            companies.removeAll()
        }
        Log("[D] \(companyPage)")
        self.companyName = companyName
        
        companyService.search(title: companyName, page: companyPage) { [weak self] result in
            Log("[D] API 호출 \(companyName)")
            guard let this = self else { return }
            switch result {
            case .success(let data):
                Log("[D] \(data.contents)")
                this.companies.append(contentsOf: data.contents)
                this.presenter.reloadCompanySearchTableView(companies: this.companies)
                this.presenter.showCompanySearchTableView()
                this.presenter.selectCompanySearchButton()
                return
            case .failure(let error):
                Log("[D] 검색 실패 \(error)")
                return
            }
        }
    }
    
    // MARK: From Child RIBs
    func tapBackButtonFromChildRIB() {
        router?.detachThisChildRIB()
    }
}
