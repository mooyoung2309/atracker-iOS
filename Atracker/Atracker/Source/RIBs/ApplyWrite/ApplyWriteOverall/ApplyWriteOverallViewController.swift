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
import RxDataSources

protocol ApplyWriteOverallPresentableListener: AnyObject {
    typealias Action = ApplyWriteOverallPresentableAction
    typealias State = ApplyWriteOverallPresentableState

    var action: ActionSubject<Action> { get }
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class ApplyWriteOverallViewController: BaseNavigationViewController, ApplyWriteOverallPresentable, ApplyWriteOverallViewControllable {
    weak var listener: ApplyWriteOverallPresentableListener?
    
//    typealias TableViewDataSource = RxTableViewSectionedReloadDataSource<SearchSectionModel>
    typealias CompanyDataSource = RxTableViewSectionedReloadDataSource<CompanySearchSectionModel>
    typealias JobTypeDataSource = RxTableViewSectionedReloadDataSource<JobTypeSearchSectionModel>
    typealias CollectionViewDataSource = RxCollectionViewSectionedReloadDataSource<StageSectionModel>
    
    // MARK: - UI Components
    
    let companySearchTextField: SearchTextField = .init(type: .company)
    let companySearchTableView: UITableView = .init()
    let jobPositionSearchTextField: SearchTextField = .init(type: .jobPosition)
    let jobTypeSearchTextField: SearchTextField = .init(type: .jobType)
    let jobTypeSearchTableView: UITableView = .init()
    let stageHeaderLabel: UILabel = .init()
    let stageSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let nextButton = UIButton(type: .system)
    
    // MARK: - Properties
    
    private lazy var companyDataSource = CompanyDataSource { _, tableView, indexPath, item -> UITableViewCell in
        switch item {
        case let .result(reactor):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CompanySearchTableViewCell.self), for: indexPath) as? CompanySearchTableViewCell else { return .init() }
            
            cell.selectionStyle = .none
            cell.reactor = reactor
            return cell
        }
    }
    
    private lazy var jobTypeDataSource = JobTypeDataSource { _, tableView, indexPath, item -> UITableViewCell in
        switch item {
        case let .result(reactor):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JobTypeSearchTableViewCell.self), for: indexPath) as? JobTypeSearchTableViewCell else { return .init() }
            
            cell.reactor = reactor
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        showNavigationBar()
        showNavigationBarBackButton()
        setNavigationBarTitle("지원 현황 추가")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        companySearchTableView.backgroundColor = .backgroundLightGray
        companySearchTableView.register(CompanySearchTableViewCell.self, forCellReuseIdentifier: String(describing: CompanySearchTableViewCell.self))
        companySearchTableView.rowHeight = 30
        
        jobTypeSearchTextField.textField.isUserInteractionEnabled = false
        
        jobTypeSearchTableView.backgroundColor = .backgroundLightGray
        jobTypeSearchTableView.register(JobTypeSearchTableViewCell.self, forCellReuseIdentifier: String(describing: JobTypeSearchTableViewCell.self))
        jobTypeSearchTableView.rowHeight = 30
        
        stageHeaderLabel.text = "지원 단계를 순서대로 눌러주세요."
        stageHeaderLabel.font = .systemFont(ofSize: 14, weight: .medium)
        stageHeaderLabel.textColor = .gray3
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews(companySearchTextField, jobPositionSearchTextField, jobTypeSearchTextField, stageHeaderLabel, nextButton, companySearchTableView, jobTypeSearchTableView, stageSearchCollectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        companySearchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        companySearchTableView.snp.makeConstraints {
            $0.top.equalTo(companySearchTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(0)
        }
        
        jobPositionSearchTextField.snp.makeConstraints {
            $0.top.equalTo(companySearchTextField.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        jobTypeSearchTextField.snp.makeConstraints {
            $0.top.equalTo(jobPositionSearchTextField.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        jobTypeSearchTableView.snp.makeConstraints {
            $0.top.equalTo(jobTypeSearchTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(0)
        }
        
        stageHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(jobTypeSearchTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        stageSearchCollectionView.snp.makeConstraints {
            $0.top.equalTo(stageHeaderLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        guard let listner = listener else { return }
        
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        companySearchTextField.textField.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .map { .textCompany($0) }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        companySearchTableView.rx.itemSelected
            .map { .selectCompany($0) }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        jobTypeSearchTextField.rx.tapGesture()
            .filter { $0.state == .ended }
            .map { _ in .toggleJobType }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        jobTypeSearchTextField.trailingButton.rx.tap
            .map{ .toggleJobType }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        jobTypeSearchTableView.rx.itemSelected
            .map { .selectJobType($0) }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
        
        listner.state.map(\.companySections)
            .bind(to: companySearchTableView.rx.items(dataSource: companyDataSource))
            .disposed(by: disposeBag)
        
        listner.state.map(\.companySections)
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.refreshTableView(tableView: this.companySearchTableView, maxHieght: 250)
            }
            .disposed(by: disposeBag)
        
        listner.state.map(\.jobTypeSections)
            .bind(to: jobTypeSearchTableView.rx.items(dataSource: jobTypeDataSource))
            .disposed(by: disposeBag)
        
        listner.state.map(\.jobTypeSections)
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.refreshTableView(tableView: this.jobTypeSearchTableView)
            }
            .disposed(by: disposeBag)
        
        listner.state.map(\.selectedCompany)
            .filter { $0 != nil }
            .map { $0?.name }
            .distinctUntilChanged()
            .bind(to: companySearchTextField.textField.rx.text)
            .disposed(by: disposeBag)
        
        listner.state.map(\.selectedJobType)
            .filter { $0 != nil }
            .map { $0?.title }
            .distinctUntilChanged()
            .bind(to: jobTypeSearchTextField.textField.rx.text)
            .disposed(by: disposeBag)
        
        listner.state.map(\.isHiddenCompany)
            .bind(to: companySearchTableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        listner.state.map(\.isHiddenJobType)
            .bind(to: jobTypeSearchTableView.rx.isHidden)
            .disposed(by: disposeBag)
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

//extension ApplyWriteOverallViewController {
//    func bindActions() {
//        guard let listner = listener else { return }
//
//        rx.viewWillAppear
//            .map { _ in () }
//            .map { .viewWillAppear }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//
//        navigaionBar.backButton.rx.tap
//            .map { .tapBackButton }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//
//        selfView.nextButton.rx.tap
//            .map { .tapNextButton }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//
//        selfView.companyUnderLineTextFieldView.textField.rx.text.orEmpty
//            .distinctUntilChanged()
//            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
//            .map { .textCompanyName($0) }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//
//        selfView.jobPositionUnderLineTextFieldView.textField.rx.text.orEmpty
//            .distinctUntilChanged()
//            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
//            .map { .textJobPosition($0) }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//
//        selfView.jobTypeUnderLineLabelView.contentLabel.rx.tapGesture()
//            .map { tap -> () in if tap.state == .ended { () } }
//            .map { .tapJobTypeToggleButton }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//    }
//}
//
//extension ApplyWriteOverallViewController {
//    func bindStates() {
//        guard let listener = listener else { return }
//
//        listener.state
//            .map { $0.companies }
//            .bind { [weak self] companies in
//                self?.reloadCompanyTableView(companies: companies)
//            }
//            .disposed(by: disposeBag)
//
//        listener.state
//            .map { $0.jobTypes }
//            .bind { [weak self] jobTypes in
//                self?.reloadJobTypeTableView(jobTypes: jobTypes)
//            }
//            .disposed(by: disposeBag)
//
//        listener.state
//            .map { $0.stages }
//            .bind { [weak self] stages in
//                self?.reloadStageCollectionView(stages: stages)
//            }
//            .disposed(by: disposeBag)
//
//        listener.state
//            .map { $0.updatedCompany }
//            .bind { [weak self] company in
//                if let company = company {
//                    self?.updateCompanyTextField(company: company)
//                }
//            }
//            .disposed(by: disposeBag)
//
//        listener.state
//            .map { $0.showCompanyTableView }
//            .bind { [weak self] bool in
//                if bool {
//                    self?.showCompanyTableView()
//                } else {
//                    self?.hideCompanyTableView()
//                }
//            }
//            .disposed(by: disposeBag)
//
//        listener.state
//            .map { $0.showJobTypeTableView }
//            .bind { [weak self] bool in
//                if bool {
//                    self?.showJobTypeTableView()
//                } else {
//                    self?.hideJobTypeTableView()
//                }
//            }
//            .disposed(by: disposeBag)
//
//        listener.state
//            .map { $0.updatedJobType }
//            .bind { [weak self] jobType in
//                if let jobType = jobType {
//                    self?.selfView.jobTypeUnderLineLabelView.contentLabel.text = jobType.title
//                }
//            }
//            .disposed(by: disposeBag)
//
//        listener.state
//            .map { $0.updatedStages }
//            .bind { [weak self] stages in
//                self?.updateStageCollectionView(stages: stages)
//            }
//            .disposed(by: disposeBag)
//    }
//}


//extension ApplyWriteOverallViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return stages.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteApplyOverallCVC.id, for: indexPath) as? WriteApplyOverallCVC else { return UICollectionViewCell() }
//
//        cell.update(title: stages[indexPath.item].title)
//
//        for (index, updateStage) in updatedStages.enumerated() {
//            if updateStage.id == stages[indexPath.item].id {
//                cell.showHighlight(order: index + 1)
//            }
//        }
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        listener?.action.onNext(.tapStageCell(stages[indexPath.item]))
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        if updatedStages.contains(where: { $0.id == stages[indexPath.item].id }) {
//            return CGSize(width: stages[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 40,
//                          height: 30)
//        } else {
//            return CGSize(width: stages[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 25,
//                          height: 30)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//}
//
//extension ApplyWriteOverallViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        switch scrollView {
//        case selfView.companySearchTableView:
//            if scrollView.contentSize.height - scrollView.contentOffset.y < Size.companySearchTableViewMaxHeight * 0.8 {
//            }
//            return
//
//        default:
//            return
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch tableView {
//        case selfView.companySearchTableView:
//            return companies.count + 1
//        case selfView.jobSearchTableView:
//            return jobTypes.count
//        default:
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch tableView {
//        case selfView.companySearchTableView:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
//
//            cell.selectionStyle = .none
//
//            if indexPath.item == companies.count {
//                cell.update(title: plusCompany)
//            } else {
//                cell.update(title: companies[indexPath.item].name)
//            }
//
//            return cell
//        case selfView.jobSearchTableView:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
//            cell.selectionStyle = .none
//            cell.update(title: jobTypes[indexPath.item].title)
//
//            return cell
//        default:
//            return UITableViewCell()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch tableView {
//        case selfView.companySearchTableView:
//            if indexPath.item == companies.count {
//                if let text = selfView.companyUnderLineTextFieldView.textField.text {
//                    listener?.action.onNext(.tapAddCompanyCell(text))
//                }
//            } else {
//                listener?.action.onNext(.tapCompanyCell(companies[indexPath.item]))
//            }
//            return
//        case selfView.jobSearchTableView:
//            listener?.action.onNext(.tapJobTypeCell(jobTypes[indexPath.item]))
//            return
//        default:
//            return
//        }
//    }
//}
