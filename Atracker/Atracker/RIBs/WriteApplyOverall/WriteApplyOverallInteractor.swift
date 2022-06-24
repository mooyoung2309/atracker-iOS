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
    func detachWriteApplyScheduleRIB()
    
}

protocol WriteApplyOverallPresentable: Presentable {
    var listener: WriteApplyOverallPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setupNavigaionBar()
    func resetCollectionView()
    func reloadCompanySearchTableView(companySearchContents: [CompanySearchContent])
    func showCompanySearchTableView()
    func hideCompanySearchTableView()
    func selectCompanySearchButton()
    func unSelectCompanySearchButton()
    func switchJobSearchTableView()
}

protocol WriteApplyOverallListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func goBackToApplyRIB()
    func goBackToWriteApplyOverallRIB()
}

final class WriteApplyOverallInteractor: PresentableInteractor<WriteApplyOverallPresentable>, WriteApplyOverallInteractable, WriteApplyOverallPresentableListener {
    
    weak var router: WriteApplyOverallRouting?
    weak var listener: WriteApplyOverallListener?
    
    private let companyService: CompanyServiceProtocol
    private var companySearchText = ""

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: WriteApplyOverallPresentable, companyService: CompanyServiceProtocol) {
        self.companyService = companyService
        
        super.init(presenter: presenter)
        
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func tapBackButton() {
        listener?.goBackToApplyRIB()
    }
    
    func tapNextButton() {
        router?.attachWriteApplyScheduleRIB()
    }
    
    func tapResetButton() {
        presenter.resetCollectionView()
    }
    
    func tapJobTypeSearchButton() {
        presenter.switchJobSearchTableView()
//        Log(Date().getDatesOfMonth())
    }
    
    func inputCompanyTextfield(text: String) {
        if text.isEmpty {
            presenter.hideCompanySearchTableView()
            presenter.unSelectCompanySearchButton()
        } else {
            companyService.search(title: text) { [weak self] result in
                switch result {
                case .success(let data):
                    Log("[D] \(data.contents)")
                    self?.presenter.reloadCompanySearchTableView(companySearchContents: data.contents)
                    self?.presenter.showCompanySearchTableView()
                    self?.presenter.selectCompanySearchButton()
                case .failure(let _):
                    return
                }
            }
        }
    }
    
    func tapCompanySearchButton() {
        
    }
    
    // MARK: From Other RIBs
    func goBackToWriteApplyOverallRIB() {
        router?.detachWriteApplyScheduleRIB()
        presenter.setupNavigaionBar()
    }
}
