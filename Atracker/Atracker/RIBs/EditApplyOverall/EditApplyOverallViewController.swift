//
//  EditApplyOverallViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift
import RxGesture
import UIKit
import SnapKit

protocol EditApplyOverallPresentableAction: AnyObject {
    var tapBackButton: Observable<Void> { get }
    var tapNextButton: Observable<Void> { get }
    var tapAddCompanyCell: Observable<String> { get }
    var tapJobType: Observable<Void> { get }
    var tapJobTypeCell: Observable<JobType> { get }
    var textCompanyName: Observable<String> { get }
    var textPositionName: Observable<String> { get }
    var textJobTypeName: Observable<String> { get }
    var changedStageProgresses: Observable<[StageProgress]> { get }
}

protocol EditApplyOverallPresentableHandler: AnyObject {
    var company: Observable<Company> { get }
    var jobPosition: Observable<String> { get }
    var jobType: Observable<JobType> { get }
    var stageProgresses: Observable<[StageProgress]> { get }
    var showCompanyTableView: Observable<[Company]> { get }
    var hideCompanyTableView: Observable<Void> { get }
    var toggleJobTypeTableView: Observable<Void> { get }
    var hideJobTypeTableView: Observable<Void> { get }
}

protocol EditApplyOverallPresentableListener: AnyObject {
    
}

final class EditApplyOverallViewController: BaseNavigationViewController, EditApplyOverallPresentable, EditApplyOverallViewControllable {
    
    weak var listener: EditApplyOverallPresentableListener?
    
    var action: EditApplyOverallPresentableAction? {
        return self
    }
    
    var handler: EditApplyOverallPresentableHandler?
    
    private let selfView = EditApplyOverallView()
    
    private let tapAddCompanyButtonSubject = PublishSubject<String>()
    private let tapJobTypeSubject = PublishSubject<Void>()
    private let tapJobTypeCellSubject = PublishSubject<JobType>()
    private let changedStageProgressesSubject = PublishSubject<[StageProgress]>()
    
    private var stageProgresses: [StageProgress] = []
    private var jobTypes: [JobType] = JobType.list
    private var companies: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfView.stageProgressTableView.reloadData()
        refreshTableView(tableView: selfView.stageProgressTableView)
        selfView.showStageCircle(max: stageProgresses.count)
        
        selfView.jobTypeTableView.reloadData()
        refreshTableView(tableView: selfView.jobTypeTableView)
        
        hideJobTypeTableView()
        hideCompanyTableView()
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        setNavigaionBarTitle("지원 현황 편집")
        showNavigationBarBackButton()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.companyTableView.delegate = self
        selfView.companyTableView.dataSource = self
        selfView.jobTypeTableView.delegate = self
        selfView.jobTypeTableView.dataSource = self
        selfView.stageProgressTableView.delegate = self
        selfView.stageProgressTableView.dataSource = self
        selfView.stageProgressTableView.dragInteractionEnabled = true
        selfView.stageProgressTableView.dragDelegate = self
        selfView.stageProgressTableView.dropDelegate = self
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
        
        guard let handler = handler else { return }
        
        // 액션 바인딩
        
        selfView.jobTypeUnderLineLabelView.rx.tapGesture()
            .bind { [weak self] tap in
                if tap.state == .ended {
                    self?.tapJobTypeSubject.onNext(())
                }
            }
            .disposed(by: disposeBag)
        
        // 핸들러 바인딩
        
        handler.stageProgresses
            .bind { [weak self] stageProgresses in
                self?.didUpdateStageProgresses(stageProgresses: stageProgresses)
            }
            .disposed(by: disposeBag)
        
        handler.company
            .bind { [weak self] company in
                self?.didUpdateCompany(company: company)
            }
            .disposed(by: disposeBag)
        
        handler.jobPosition
            .bind { [weak self] jobPosition in
                self?.didUpdateJobPosition(jobPosition: jobPosition)
            }
            .disposed(by: disposeBag)
        
        handler.jobType
            .bind { [weak self] jobType in
                self?.didUpdateJobType(jobType: jobType)
            }
            .disposed(by: disposeBag)
        
        handler.showCompanyTableView
            .bind { [weak self] companies in
                self?.showCompanyTableView(companies: companies)
            }
            .disposed(by: disposeBag)
        
        handler.hideCompanyTableView
            .bind { [weak self] in
                self?.hideCompanyTableView()
            }
            .disposed(by: disposeBag)
        
        handler.toggleJobTypeTableView
            .bind { [weak self] in
                self?.toggleJobTypeTableView()
            }
            .disposed(by: disposeBag)
        
        handler.hideJobTypeTableView
            .bind { [weak self] in
                self?.hideJobTypeTableView()
            }
            .disposed(by: disposeBag)
    }
    
    private func toggleJobTypeTableView() {
        let bool = selfView.jobTypeTableView.isHidden
        
        selfView.jobTypeTableView.isHidden = !bool
    }
    
    private func updateStageProgressesForHandler() {
        changedStageProgressesSubject.onNext(stageProgresses)
    }
    
    private func didUpdateTapAddCompanyButton() {
        if let companyName = selfView.companyUnderLineTextFieldView.textField.text {
            tapAddCompanyButtonSubject.onNext(companyName)
        }
    }
    
    private func showCompanyTableView(companies: [Company]) {
        self.companies = companies
        selfView.companyTableView.isHidden = false
        selfView.companyTableView.reloadData()
        refreshTableView(tableView: selfView.companyTableView, maxHieght: Size.companySearchTableViewMaxHeight)
    }
    
    private func hideCompanyTableView() {
        selfView.companyTableView.isHidden = true
    }
    
    private func showJobTypeTableView(jobTypes: [JobType]) {
        self.jobTypes = jobTypes
        selfView.jobTypeTableView.isHidden = false
        selfView.jobTypeTableView.reloadData()
        refreshTableView(tableView: selfView.jobTypeTableView)
    }
    
    private func hideJobTypeTableView() {
        selfView.jobTypeTableView.isHidden = true
    }
    
    private func didUpdateStageProgresses(stageProgresses: [StageProgress]) {
        self.stageProgresses = stageProgresses
        selfView.stageProgressTableView.reloadData()
        selfView.showStageCircle(max: stageProgresses.count)
        refreshTableView(tableView: selfView.stageProgressTableView)
    }
    
    private func didUpdateCompany(company: Company) {
        selfView.companyUnderLineTextFieldView.textField.text = company.name
    }
    
    private func didUpdateJobPosition(jobPosition: String) {
        selfView.positionUnderLineTextFieldView.textField.text = jobPosition
    }
    
    private func didUpdateJobType(jobType: JobType) {
        selfView.jobTypeUnderLineLabelView.contentLabel.text = jobType.title
    }
}

extension EditApplyOverallViewController: EditApplyOverallPresentableAction {
    var tapBackButton: Observable<Void> {
        return navigaionBar.backButton.rx.tap.asObservable()
    }
    
    var tapNextButton: Observable<Void> {
        return selfView.nextButton.rx.tap.asObservable()
    }
    
    var tapAddCompanyCell: Observable<String> {
        return tapAddCompanyButtonSubject.asObservable()
    }
    
    var tapJobTypeCell: Observable<JobType> {
        return tapJobTypeCellSubject.asObservable()
    }
    
    var tapJobType: Observable<Void> {
        return tapJobTypeSubject.asObservable()
    }
    
    var textJobTypeName: Observable<String> {
        return PublishSubject<String>().asObservable()
    }
    
    var textCompanyName: Observable<String> {
        return selfView.companyUnderLineTextFieldView.textField.rx.text.orEmpty.distinctUntilChanged().asObservable()
    }
    
    var textPositionName: Observable<String> {
        return selfView.positionUnderLineTextFieldView.textField.rx.text.orEmpty.asObservable()
    }
    
    var changedStageProgresses: Observable<[StageProgress]> {
        return changedStageProgressesSubject.asObservable()
    }
}

extension EditApplyOverallViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        Log("[D] \(dragItem)")
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        Log("[D] \(coordinator.items)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case selfView.companyTableView:
            return companies.count + 1
        case selfView.stageProgressTableView:
            return stageProgresses.count
        case selfView.jobTypeTableView:
            return jobTypes.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case selfView.stageProgressTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DraggableStageTVC.id, for: indexPath) as? DraggableStageTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.containerView.layer.cornerRadius = 10
                cell.containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else if indexPath.row == stageProgresses.count - 1 {
                cell.containerView.layer.cornerRadius = 10
                cell.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            cell.update(title: stageProgresses[indexPath.item].stageTitle)
            return cell
        case selfView.companyTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            if indexPath.item < companies.count {
                cell.update(title: companies[indexPath.item].name)
            } else {
                cell.update(title: "+ 직접 추가")
            }
            return cell
        case selfView.jobTypeTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.update(title: jobTypes[indexPath.item].title)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("[D] \(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        let moveCell = stageProgresses[sourceIndexPath.row]
        stageProgresses.remove(at: sourceIndexPath.row)
        stageProgresses.insert(moveCell, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        
        let param = UIDragPreviewParameters()
        param.backgroundColor = .clear
        return param
    }
    
    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        
        let param = UIDragPreviewParameters()
        param.backgroundColor = .clear
        return param
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case selfView.companyTableView:
            Log("[D] \(indexPath.item)")
            didUpdateTapAddCompanyButton()
        case selfView.jobTypeTableView:
            tapJobTypeCellSubject.onNext(jobTypes[indexPath.item])
        default:
            break
        }
    }
    
}
