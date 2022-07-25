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

// MARK: - Presenter
protocol WriteApplyOverallPresentableAction: AnyObject {
    var tapBackButton: Observable<Void> { get }
    var tapNextButton: Observable<Void> { get }
    var tapAddCompanyButton: Observable<String> { get }
    var tapJobTypeButton: Observable<Void> { get }
    var textCompanyName: Observable<String> { get }
    var textPositionName: Observable<String> { get }
    var textJobTypeName: Observable<String> { get }
    var selectedCompany: Observable<Company> { get }
    var selectedStages: Observable<[Stage]> { get }
}

protocol WriteApplyOverallPresentableHandler: AnyObject {
    var companies: Observable<[Company]> { get }
    var stages: Observable<[Stage]> { get }
    var isShowCompanyTableView: Observable<Bool> { get }
    var isShowJobTypeTableView: Observable<Bool> { get }
}

protocol WriteApplyOverallPresentableListener: AnyObject {
    
}

final class WriteApplyOverallViewController: BaseNavigationViewController, WriteApplyOverallPresentable, WriteApplyOverallViewControllable {
    
    weak var listener: WriteApplyOverallPresentableListener?
    
    var action: WriteApplyOverallPresentableAction? {
        return self
    }
    
    var handler: WriteApplyOverallPresentableHandler?
    
    let selfView = WriteApplyOverallView()
    
    private let tapAddCompanyButtonSubject = PublishSubject<String>()
    private let textJobTypeNameSubject = PublishSubject<String>()
    private let textCompanyNameSubject = BehaviorRelay<String>(value: "")
    private let selectedCompanySubject = PublishSubject<Company>()
    private let selectedStagesSubject = BehaviorSubject<[Stage]>(value: [])
    
    private var selectedIndexPathList: [IndexPath] = []
    private var stages: [Stage] = []
    private var jobTypes: [String] = []
    private var companies: [Company] = []
    private var tmpSelectedStages: [Stage] = []
    private let plusCompany = "+ 직접 추가"
    
    func reloadCompanySearchTableView(companies: [Company]) {
        self.companies = companies
        selfView.companySearchTableView.reloadData()
        refreshTableView(tableView: selfView.companySearchTableView, maxHieght: Size.companySearchTableViewMaxHeight)
    }
    
    func reloadStageCollectionView(stages: [Stage]) {
        self.stages = stages
        selfView.collectionView.reloadData()
    }
    
    func showCompanyTableView() {
        selfView.companySearchTableView.isHidden = false
        Log("[D] 보여짐")
    }
    
    func hideCompanyTableView() {
        selfView.companySearchTableView.isHidden = true
        Log("[D] 가려짐")
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
        setupNavigaionBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        jobTypes = [JobType.permanent.title, JobType.temporary.title, JobType.intern.title]
        selfView.jobSearchTableView.reloadData()
        refreshTableView(tableView: selfView.jobSearchTableView)
        selfView.jobSearchTableView.isHidden = true
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
        
        guard let action = action else { return }
        guard let handler = handler else { return }
        
        selfView.companyUnderLineTextFieldView.textField.rx.text.orEmpty
            .bind(to: textCompanyNameSubject)
            .disposed(by: disposeBag)
        
        action.selectedCompany
            .bind { [weak self] company in
                self?.selfView.companyUnderLineTextFieldView.textField.text = company.name
            }
            .disposed(by: disposeBag)

        action.textJobTypeName
            .bind { [weak self] text in
                self?.updateJobTypeLabel(text: text)
            }
            .disposed(by: disposeBag)

        handler.companies
            .bind { [weak self] companies in
                Log("[D] 회사 결과들 \(companies)")
                self?.reloadCompanySearchTableView(companies: companies)
            }
            .disposed(by: disposeBag)

        handler.stages
            .bind { [weak self] stages in
                self?.reloadStageCollectionView(stages: stages)
            }
            .disposed(by: disposeBag)

        handler.isShowCompanyTableView
            .bind { [weak self] bool in
                if bool {
                    self?.showCompanyTableView()
                } else {
                    self?.hideCompanyTableView()
                }
            }
            .disposed(by: disposeBag)

        handler.isShowJobTypeTableView
            .bind { [weak self] bool in
                if bool {
                    self?.showJobTypeTableView()
                } else {
                    self?.hideJobTypeTableView()
                }
            }
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

extension WriteApplyOverallViewController: WriteApplyOverallPresentableAction {
    var tapBackButton: Observable<Void> {
        return navigaionBar.backButton.rx.tap.asObservable()
    }
    
    var tapNextButton: Observable<Void> {
        return selfView.nextButton.rx.tap.asObservable()
    }
    
    var tapAddCompanyButton: Observable<String> {
        return tapAddCompanyButtonSubject.asObservable()
    }
    
    var tapJobTypeButton: Observable<Void> {
        return selfView.jobTypeUnderLineLabelView.button.rx.tap.asObservable()
    }
    
    var textCompanyName: Observable<String> {
        return textCompanyNameSubject.asObservable()
    }
    
    var textPositionName: Observable<String> {
        return selfView.positionUnderLineTextFieldView.textField.rx.text.orEmpty.asObservable()
    }
    
    var textJobTypeName: Observable<String> {
        return textJobTypeNameSubject.asObservable()
    }
    
    var selectedCompany: Observable<Company> {
        return selectedCompanySubject.asObservable()
    }
    
    var selectedStages: Observable<[Stage]> {
        return selectedStagesSubject.asObservable()
    }
}

extension WriteApplyOverallViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteApplyOverallCVC.id, for: indexPath) as? WriteApplyOverallCVC else { return UICollectionViewCell() }
        
        cell.update(title: stages[indexPath.item].title)
        
        if selectedIndexPathList.contains(indexPath) {
            if let order = selectedIndexPathList.firstIndex(of: indexPath) {
                //                Log("[D] \(order)")
                cell.showHighlight(order: order + 1)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPathList.contains(indexPath) {
            selectedIndexPathList.removeElementByReference(indexPath)
            tmpSelectedStages.removeAll(where: { $0.id == stages[indexPath.item].id })
            
        } else {
            selectedIndexPathList.append(indexPath)
            tmpSelectedStages.append(stages[indexPath.item])
        }
        
        selectedStagesSubject.onNext(tmpSelectedStages)
        
        collectionView.performBatchUpdates(nil, completion: { _ in
            collectionView.reloadData()
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if selectedIndexPathList.contains(indexPath) {
            return CGSize(width: stages[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 40,
                          height: 30)
        }
        
        return CGSize(width: stages[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 25,
                      height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension WriteApplyOverallViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case selfView.companySearchTableView:
            if scrollView.contentSize.height - scrollView.contentOffset.y < Size.companySearchTableViewMaxHeight * 0.8 {
                Log("[D] 테이블 뷰 로딩 . . . 회사 검색")
//                listener?.searchCompanyName(text: nil)
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
            cell.update(title: jobTypes[indexPath.item])
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case selfView.companySearchTableView:
            if indexPath.item == companies.count {
                tapAddCompanyButtonSubject.onNext(textCompanyNameSubject.value)
            } else {
                selectedCompanySubject.onNext(companies[indexPath.item])
            }
            return
        case selfView.jobSearchTableView:
            textJobTypeNameSubject.onNext(jobTypes[indexPath.item])
            return
        default:
            return
        }
    }
}
