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

protocol WriteApplyOverallPresentableListener: AnyObject {
    func tapBackButton()
    func tapNextButton()
    func tapResetButton()
//    func inputCompanyTextfield(text: String)
    func tapCompanySearchButton()
    func tapCompanyTableView(company: Company)
    func tapJobTypeSearchButton()
    func tapJobTypeTableView(text: String)
    func searchCompanyName(text: String?)
    func tapPlusCompay()
}

final class WriteApplyOverallViewController: BaseNavigationViewController, WriteApplyOverallPresentable, WriteApplyOverallViewControllable {
    
    
    var thisView: UIView {
        return containerView
    }
    
    weak var listener: WriteApplyOverallPresentableListener?
    
    let selfView = WriteApplyOverallView()
    
    private var selectedIndexPathList: [IndexPath] = []
    private var stages: [Stage] = []
//    = ["서류", "사전과제", "포트폴리오", "1차 면접", "2차 면접", "인성검사", "적성검사", "코딩테스트"]
    private let jobTypes: [String] = [JobType.fullTime.string, JobType.contract.string, JobType.intern.string]
    private var companies: [Company] = []
    private let plusCompany = "+ 직접 추가"
    
    func updateStageCollectionView(stages: [Stage]) {
        self.stages = stages
        selfView.collectionView.reloadData()
    }
    
    func resetCollectionView() {
        selectedIndexPathList.removeAll()
        selfView.collectionView.reloadData()
    }
    
    func reloadCompanySearchTableView(companies: [Company]) {
        self.companies = companies
        Log("[D] \(self.companies)")
        selfView.companySearchTableView.reloadData()
        refreshTableView(tableView: selfView.companySearchTableView, maxHieght: Size.companySearchTableViewMaxHeight)
    }
    
    func showCompanySearchTableView() {
        selfView.companySearchTableView.isHidden = false
    }
    
    func hideCompanySearchTableView() {
        selfView.companySearchTableView.isHidden = true
    }
    
    func updateCompanyTextField(text: String) {
        selfView.companyUnderLineTextFieldView.textField.text = text
    }
    
    func selectCompanySearchButton() {
        selfView.companyUnderLineTextFieldView.button.isSelected = true
    }
    
    func unSelectCompanySearchButton() {
        selfView.companyUnderLineTextFieldView.button.isSelected = false
    }
    
    func switchJobTypeSearchTableView() {
        let bool = !selfView.jobSearchTableView.isHidden
        selfView.jobSearchTableView.isHidden = bool
        selfView.jobTypeUnderLineLabelView.isHighlight = !bool
    }
    
    func updateJobTypeLabel(text: String) {
        selfView.jobTypeUnderLineLabelView.contentText = text
    }
    
    func updateCompanyLabel(text: String) {
        selfView.companyUnderLineTextFieldView.textField.text = text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigaionBar()
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
        
        selfView.collectionView.delegate            = self
        selfView.collectionView.dataSource          = self
        selfView.companySearchTableView.delegate    = self
        selfView.companySearchTableView.dataSource  = self
        selfView.jobSearchTableView.delegate        = self
        selfView.jobSearchTableView.dataSource      = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        view.layer.zPosition = 1
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
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
        
        selfView.nextButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapNextButton()
            }
            .disposed(by: disposeBag)
        
        selfView.reloadButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapResetButton()
            }
            .disposed(by: disposeBag)
        
        selfView.companyUnderLineTextFieldView.textField.rx.text
            .bind { [weak self] text in
                if let text = text {
                    self?.listener?.searchCompanyName(text: text)
                }
            }
            .disposed(by: disposeBag)
        
        selfView.companyUnderLineTextFieldView.button.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapCompanySearchButton()
            }
            .disposed(by: disposeBag)
        
        selfView.jobTypeUnderLineLabelView.button.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapJobTypeSearchButton()
            }
            .disposed(by: disposeBag)
        
        selfView.jobTypeUnderLineLabelView.rx.tapGesture()
            .bind { [weak self] tap in
                if tap.state == .ended {
                    self?.listener?.tapJobTypeSearchButton()
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
        } else {
            selectedIndexPathList.append(indexPath)
        }
        
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
                listener?.searchCompanyName(text: nil)
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
                listener?.tapPlusCompay()
            } else {
                listener?.tapCompanyTableView(company: companies[indexPath.item])
            }
            
            return
        case selfView.jobSearchTableView:
            listener?.tapJobTypeTableView(text: jobTypes[indexPath.item])
            return
        default:
            return
        }
    }
}
