//
//  ApplyWriteViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol WriteApplyOverallPresentableListener: AnyObject {
    func tapBackButton()
    func tapNextButton()
    func tapResetButton()
    func inputCompanyTextfield(text: String)
    func tapCompanySearchButton()
    func tapJobTypeSearchButton()
}

final class WriteApplyOverallViewController: BaseNavigationViewController, WriteApplyOverallPresentable, WriteApplyOverallViewControllable {
    var thisView: UIView {
        return containerView
    }
    
    weak var listener: WriteApplyOverallPresentableListener?
    
    let selfView = WriteApplyOverallView()
    
    private var selectedIndexPathList: [IndexPath] = []
    private let mockups = ["서류", "사전과제", "포트폴리오", "1차 면접", "2차 면접", "인성검사", "적성검사", "코딩테스트"]
    private let jobTypes: [JobType] = [JobType.fullTime, JobType.contract, JobType.intern]
    private var companySearchContents: [CompanySearchContent] = []
    
    func resetCollectionView() {
        selectedIndexPathList.removeAll()
        selfView.collectionView.reloadData()
    }
    
    func reloadCompanySearchTableView(companySearchContents: [CompanySearchContent]) {
        self.companySearchContents = companySearchContents
        Log("[D] \(self.companySearchContents)")
        selfView.companySearchTableView.reloadData()
        refreshTableView(tableView: selfView.companySearchTableView, maxHieght: Size.companySearchTableViewMaxHeight)
    }
    
    func showCompanySearchTableView() {
        selfView.companySearchTableView.isHidden = false
    }
    
    func hideCompanySearchTableView() {
        selfView.companySearchTableView.isHidden = true
    }
    
    func selectCompanySearchButton() {
        selfView.companySearchButton.isSelected = true
    }
    
    func unSelectCompanySearchButton() {
        selfView.companySearchButton.isSelected = false
    }
    
    func switchJobSearchTableView() {
        let bool = !selfView.jobSearchTableView.isHidden
        selfView.jobSearchTableView.isHidden = bool
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
        
        selfView.companyTextField.rx.text
            .bind { [weak self] text in
                if let text = text {
                    self?.listener?.inputCompanyTextfield(text: text)
                }
            }
            .disposed(by: disposeBag)
        
        selfView.companySearchButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapCompanySearchButton()
            }
            .disposed(by: disposeBag)
        
        selfView.jobTypeButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapJobTypeSearchButton()
            }
            .disposed(by: disposeBag)
    }
}

extension WriteApplyOverallViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteApplyOverallCVC.id, for: indexPath) as? WriteApplyOverallCVC else { return UICollectionViewCell() }
        
        cell.update(title: mockups[indexPath.item])
        
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
            return CGSize(width: mockups[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 40,
                          height: 30)
        }
        
        return CGSize(width: mockups[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 25,
                      height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension WriteApplyOverallViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Log(companySearchContents.count)
        switch tableView {
        case selfView.companySearchTableView:
            return companySearchContents.count
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
            //            Log("[D] \(companySearchContents[indexPath.item].name)")
            cell.update(title: companySearchContents[indexPath.item].name)
            
            return cell
        case selfView.jobSearchTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTVC.id, for: indexPath) as? SearchTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.update(title: jobTypes[indexPath.item].string)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
