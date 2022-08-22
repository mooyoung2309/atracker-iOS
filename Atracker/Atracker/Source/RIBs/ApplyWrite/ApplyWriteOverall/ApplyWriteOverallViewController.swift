//
//  ApplyWriteViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift
import RxCocoa
import RxGesture
import UIKit
import SnapKit
import Alamofire
import ReactorKit

// MARK: - Presenter


//protocol ApplyWriteOverallPresentableAction: AnyObject {
//    var tapBackButton: Observable<Void> { get }
//    var tapNextButton: Observable<Void> { get }
//    var tapAddCompanyButton: Observable<String> { get }
//    var tapJobTypeButton: Observable<Void> { get }
//    var textCompanyName: Observable<String> { get }
//    var textPositionName: Observable<String> { get }
//    var textJobTypeName: Observable<String> { get }
//    var selectedCompany: Observable<Company> { get }
//    var selectedStages: Observable<[Stage]> { get }
//}
//
//protocol ApplyWriteOverallPresentableHandler: AnyObject {
//    var companies: Observable<[Company]> { get }
//    var stages: Observable<[Stage]> { get }
//    var isShowCompanyTableView: Observable<Bool> { get }
//    var isShowJobTypeTableView: Observable<Bool> { get }
//}

protocol ApplyWriteOverallPresentableListener: AnyObject {
    typealias Action = ApplyWriteOverallPresentableAction
    typealias State = ApplyWriteOverallPresentableState

    var action: ActionSubject<Action> { get }
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class ApplyWriteOverallViewController: BaseNavigationViewController, ApplyWriteOverallPresentable, ApplyWriteOverallViewControllable {
    weak var listener: ApplyWriteOverallPresentableListener?

    let selfView = WriteApplyOverallView()
    
    private let tapAddCompanyButtonSubject = PublishSubject<String>()
    private let textJobTypeNameSubject = PublishSubject<String>()
    private let textCompanyNameSubject = BehaviorRelay<String>(value: "")
    private let selectedCompanySubject = PublishSubject<Company>()
    private let selectedStagesSubject = BehaviorSubject<[Stage]>(value: [])
    
    private var selectedIndexPathList: [IndexPath] = []
    private var jobTypes: [JobType] = []
    private var companies: [Company] = []
    private var stages: [Stage] = []
    private var updatedStages: [Stage] = []
    private let plusCompany = "+ 직접 추가"
    
    func reloadCompanyTableView(companies: [Company]) {
        self.companies = companies
        refreshTableView(tableView: selfView.companySearchTableView, maxHieght: Size.companySearchTableViewMaxHeight)
    }
    
    func reloadJobTypeTableView(jobTypes: [JobType]) {
        self.jobTypes = jobTypes
        refreshTableView(tableView: selfView.jobSearchTableView)
    }
    
    func reloadStageCollectionView(stages: [Stage]) {
        self.stages = stages
        selfView.collectionView.reloadData()
    }
    
    func updateStageCollectionView(stages: [Stage]) {
        self.updatedStages = stages
        selfView.collectionView.performBatchUpdates(nil, completion: { _ in
            self.selfView.collectionView.reloadData()
        })
    }
    
    func updateCompanyTextField(company: Company) {
        selfView.companyUnderLineTextFieldView.textField.text = company.name
    }
    
    func showCompanyTableView() {
        selfView.companySearchTableView.isHidden = false
    }
    
    func hideCompanyTableView() {
        selfView.companySearchTableView.isHidden = true
    }
    
    func showJobTypeTableView() {
        selfView.jobSearchTableView.isHidden = false
    }
    
    func hideJobTypeTableView() {
        selfView.jobSearchTableView.isHidden = true
    }

    func updateJobTypeLabel(text: String?) {
        if let text = text {
            selfView.jobTypeUnderLineLabelView.contentText = text
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        jobTypes = [JobType.permanent.title, JobType.temporary.title, JobType.intern.title]
//        selfView.jobSearchTableView.reloadData()
//        refreshTableView(tableView: selfView.jobSearchTableView)
//        selfView.jobSearchTableView.isHidden = true
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        showNavigationBar()
        showNavigationBarBackButton()
        setNavigaionBarTitle("지원 현황 추가")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.collectionView.delegate = self
        selfView.collectionView.dataSource = self
        selfView.companySearchTableView.delegate = self
        selfView.companySearchTableView.dataSource = self
        selfView.jobSearchTableView.delegate = self
        selfView.jobSearchTableView.dataSource = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        contentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        bindActions()
        bindStates()

//        guard let action = action else { return }
//        guard let handler = handler else { return }
//        
//        selfView.companyUnderLineTextFieldView.textField.rx.text.orEmpty
//            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
//            .bind(to: textCompanyNameSubject)
//            .disposed(by: disposeBag)
//        
//        selfView.rx.tapGesture()
//            .bind { [weak self] tap in
//                if tap.state == .ended {
//                    self?.hideCompanyTableView()
//                    self?.hideJobTypeTableView()
//                }
//            }
//            .disposed(by: disposeBag)
//        
//        action.selectedCompany
//            .bind { [weak self] company in
//                self?.selfView.companyUnderLineTextFieldView.textField.text = company.name
//            }
//            .disposed(by: disposeBag)
//
//        action.textJobTypeName
//            .bind { [weak self] text in
//                self?.updateJobTypeLabel(text: text)
//            }
//            .disposed(by: disposeBag)
//
//        handler.companies
//            .bind { [weak self] companies in
//                Log("[D] 회사 결과들 \(companies)")
//                self?.reloadCompanySearchTableView(companies: companies)
//            }
//            .disposed(by: disposeBag)
//
//        handler.stages
//            .bind { [weak self] stages in
//                self?.reloadStageCollectionView(stages: stages)
//            }
//            .disposed(by: disposeBag)
//
//        handler.isShowCompanyTableView
//            .bind { [weak self] bool in
//                if bool {
//                    self?.showCompanyTableView()
//                } else {
//                    self?.hideCompanyTableView()
//                }
//            }
//            .disposed(by: disposeBag)
//
//        handler.isShowJobTypeTableView
//            .bind { [weak self] bool in
//                if bool {
//                    self?.showJobTypeTableView()
//                } else {
//                    self?.hideJobTypeTableView()
//                }
//            }
//            .disposed(by: disposeBag)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

extension ApplyWriteOverallViewController {
    func bindActions() {
        guard let listner = listener else { return }
        
        rx.viewWillAppear
            .map { _ in () }
            .map { .viewWillAppear }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        navigaionBar.backButton.rx.tap
            .map { .tapBackButton }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        selfView.nextButton.rx.tap
            .map { .tapNextButton }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        selfView.companyUnderLineTextFieldView.textField.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .map { .textCompanyName($0) }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        selfView.jobPositionUnderLineTextFieldView.textField.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .map { .textJobPosition($0) }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        selfView.jobTypeUnderLineLabelView.contentLabel.rx.tapGesture()
            .map { tap -> () in if tap.state == .ended { () } }
            .map { .tapJobTypeToggleButton }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
    }
}

extension ApplyWriteOverallViewController {
    func bindStates() {
        guard let listener = listener else { return }
        
        listener.state
            .map { $0.companies }
            .bind { [weak self] companies in
                self?.reloadCompanyTableView(companies: companies)
            }
            .disposed(by: disposeBag)
        
        listener.state
            .map { $0.jobTypes }
            .bind { [weak self] jobTypes in
                self?.reloadJobTypeTableView(jobTypes: jobTypes)
            }
            .disposed(by: disposeBag)
        
        listener.state
            .map { $0.stages }
            .bind { [weak self] stages in
                self?.reloadStageCollectionView(stages: stages)
            }
            .disposed(by: disposeBag)
        
        listener.state
            .map { $0.updatedCompany }
            .bind { [weak self] company in
                if let company = company {
                    self?.updateCompanyTextField(company: company)
                }
            }
            .disposed(by: disposeBag)
        
        listener.state
            .map { $0.showCompanyTableView }
            .bind { [weak self] bool in
                if bool {
                    self?.showCompanyTableView()
                } else {
                    self?.hideCompanyTableView()
                }
            }
            .disposed(by: disposeBag)
        
        listener.state
            .map { $0.showJobTypeTableView }
            .bind { [weak self] bool in
                if bool {
                    self?.showJobTypeTableView()
                } else {
                    self?.hideJobTypeTableView()
                }
            }
            .disposed(by: disposeBag)
        
        listener.state
            .map { $0.updatedJobType }
            .bind { [weak self] jobType in
                if let jobType = jobType {
                    self?.selfView.jobTypeUnderLineLabelView.contentLabel.text = jobType.title
                }
            }
            .disposed(by: disposeBag)
        
        listener.state
            .map { $0.updatedStages }
            .bind { [weak self] stages in
                self?.updateStageCollectionView(stages: stages)
            }
            .disposed(by: disposeBag)
    }
}


extension ApplyWriteOverallViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteApplyOverallCVC.id, for: indexPath) as? WriteApplyOverallCVC else { return UICollectionViewCell() }
        
        cell.update(title: stages[indexPath.item].title)
        
        for (index, updateStage) in updatedStages.enumerated() {
            if updateStage.id == stages[indexPath.item].id {
                cell.showHighlight(order: index + 1)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.action.onNext(.tapStageCell(stages[indexPath.item]))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if updatedStages.contains(where: { $0.id == stages[indexPath.item].id }) {
            return CGSize(width: stages[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 40,
                          height: 30)
        } else {
            return CGSize(width: stages[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 25,
                          height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension ApplyWriteOverallViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case selfView.companySearchTableView:
            if scrollView.contentSize.height - scrollView.contentOffset.y < Size.companySearchTableViewMaxHeight * 0.8 {
            }
            return
            
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case selfView.companySearchTableView:
            return companies.count + 1
        case selfView.jobSearchTableView:
            return jobTypes.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case selfView.companySearchTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            if indexPath.item == companies.count {
                cell.update(title: plusCompany)
            } else {
                cell.update(title: companies[indexPath.item].name)
            }
            
            return cell
        case selfView.jobSearchTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.update(title: jobTypes[indexPath.item].title)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case selfView.companySearchTableView:
            if indexPath.item == companies.count {
                if let text = selfView.companyUnderLineTextFieldView.textField.text {
                    listener?.action.onNext(.tapAddCompanyCell(text))
                }
            } else {
                listener?.action.onNext(.tapCompanyCell(companies[indexPath.item]))
            }
            return
        case selfView.jobSearchTableView:
            listener?.action.onNext(.tapJobTypeCell(jobTypes[indexPath.item]))
            return
        default:
            return
        }
    }
}
