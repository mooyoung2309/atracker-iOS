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

    func sendAction(_ action: Action)
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class ApplyWriteOverallViewController: BaseNavigationViewController, ApplyWriteOverallPresentable, ApplyWriteOverallViewControllable {
    
    // MARK: - Properties
    
    weak var listener: ApplyWriteOverallPresentableListener?
    
    typealias CompanyDataSource = RxTableViewSectionedReloadDataSource<CompanySearchSectionModel>
    typealias JobTypeDataSource = RxTableViewSectionedReloadDataSource<JobTypeSearchSectionModel>
    typealias StageDataSource = RxCollectionViewSectionedReloadDataSource<StageSearchSectionModel>
    
    private let actionRelay = PublishRelay<ApplyWriteOverallPresentableListener.Action>()
    
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
            
            cell.selectionStyle = .none
            cell.reactor = reactor
            return cell
        }
    }
    
    private lazy var stageDataSource = StageDataSource {_, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .result(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StageSearchCollectionViewCell.self), for: indexPath) as? StageSearchCollectionViewCell else { return .init() }
            
            cell.reactor = reactor
            return cell
        }
    }
    
    // MARK: - UI Components
    
    let companySearchTextField: SearchTextField = .init(type: .company)
    let companySearchTableView: UITableView = .init()
    let jobPositionSearchTextField: SearchTextField = .init(type: .jobPosition)
    let jobTypeSearchTextField: SearchTextField = .init(type: .jobType)
    let jobTypeSearchTableView: UITableView = .init()
    let stageHeaderLabel: UILabel = .init()
    let stageSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let nextButton: AtrackerButton = .init(type: .next)
    
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
        
        stageSearchCollectionView.backgroundColor = .clear
        stageSearchCollectionView.register(StageSearchCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: StageSearchCollectionViewCell.self))
        
        stageHeaderLabel.text = "지원 단계를 순서대로 눌러주세요."
        stageHeaderLabel.font = .systemFont(ofSize: 14, weight: .medium)
        stageHeaderLabel.textColor = .gray3
        
//        nextButton.setTitle("다음", for: .normal)
//        nextButton.setTitleColor(.neonGreen, for: .normal)
//        nextButton.backgroundColor = .backgroundGray
//        nextButton.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews(companySearchTextField, jobPositionSearchTextField, jobTypeSearchTextField, stageHeaderLabel, nextButton, stageSearchCollectionView, companySearchTableView, jobTypeSearchTableView)
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
            $0.height.equalTo(200)
        }
        
        nextButton.snp.makeConstraints {
            $0.height.equalTo(Size.tabBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        guard let listner = listener else { return }
        
        self.actionRelay.asObservable()
            .bind() { [weak self] action in
                self?.listener?.sendAction(action)
            }
          .disposed(by: disposeBag)
        
        self.rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.navigaionBar.backButton.rx.tap
            .map { .tapBackButton }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.companySearchTextField.textField.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .map { .textCompany($0) }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.companySearchTableView.rx.itemSelected
            .map { .selectCompany($0) }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.jobTypeSearchTextField.rx.tapGesture()
            .filter { $0.state == .ended }
            .map { _ in .toggleJobType }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.jobTypeSearchTextField.trailingButton.rx.tap
            .map{ .toggleJobType }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.jobTypeSearchTableView.rx.itemSelected
            .map { .selectJobType($0) }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.stageSearchCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        self.stageSearchCollectionView.rx.itemSelected
            .map { .selectStage($0) }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.nextButton.rx.tap
            .map { .tapNextButton }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        listner.state.map(\.companySections)
            .bind(to: companySearchTableView.rx.items(dataSource: companyDataSource))
            .disposed(by: disposeBag)
        
        listner.state.map(\.companySections)
            .bind { [weak self] _ in
                guard let `self` = self else { return }
                self.refreshTableView(tableView: self.companySearchTableView, maxHieght: 250)
            }
            .disposed(by: disposeBag)
        
        listner.state.map(\.jobTypeSections)
            .bind(to: jobTypeSearchTableView.rx.items(dataSource: jobTypeDataSource))
            .disposed(by: disposeBag)
        
        listner.state
            .map(\.jobTypeSections)
            .bind { [weak self] _ in
                guard let `self` = self else { return }
                self.refreshTableView(tableView: self.jobTypeSearchTableView)
            }
            .disposed(by: disposeBag)
        
        listner.state
            .map(\.stageSections)
            .bind(to: stageSearchCollectionView.rx.items(dataSource: stageDataSource))
            .disposed(by: disposeBag)
        
        listner.state
            .compactMap(\.selectedCompany?.name)
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
}

extension ApplyWriteOverallViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch stageDataSource[indexPath.section].items[indexPath.row] {
        case let .result(reactor):
            if let _ = reactor.currentState.order {
                return CGSize(width: reactor.currentState.stage.title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width + 50, height: 32)
            } else {
                return CGSize(width: reactor.currentState.stage.title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width + 30, height: 32)
            }
        }
    }
}
