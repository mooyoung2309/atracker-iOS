//
//  ApplyEditViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol ApplyEditPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func reloadTableView(stageProgressTitle: String)
    func didTapBackButton()
    func tapStageStatusButton(status: ProgressStatus)
    func tapEditButton()
    func tapEditCompleteButton()
    func tapDeleteButton()
    func tapAlertBackButton()
    func tapAlertNextButton()
}

final class ApplyEditViewController: BaseNavigationViewController, ApplyEditPresentable, ApplyEditViewControllable {
    
    weak var listener: ApplyEditPresentableListener?
    
    let selfView            = ApplyEditView()
//    var alertView           = AlertView(style: .delete, i: 0)
    let collectionMockUps   = ["서류", "사전과제", "1차 면접", "2차 면접", "인적성 검사", "최종 면접"]
    let tableMockUps        = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    private var stageContentList: [StageContent]    = []
    private var isEditButtonClicked                 = false
    
    func highlightStageStatusButton(status: ProgressStatus) {
        selfView.stageStatusButtonBar.notStartedButton.isSelected   = false
        selfView.stageStatusButtonBar.failButton.isSelected         = false
        selfView.stageStatusButtonBar.passButton.isSelected         = false
        
        switch status {
        case .notStarted:
            selfView.stageStatusButtonBar.notStartedButton.isSelected = true
            break
        case .fail:
            selfView.stageStatusButtonBar.failButton.isSelected = true
            break
        case .pass:
            selfView.stageStatusButtonBar.passButton.isSelected = true
            break
        }
    }
    
    func showStageContentList(_ stageContentList: [StageContent]) {
        self.stageContentList = stageContentList
        selfView.tableView.reloadData()
        refreshTableView(tableView: selfView.tableView)
    }
    
    func showStageStatusButtonBar() {
        selfView.stageStatusButtonBar.isHidden  = false
        selfView.reviewDeleteButtonBar.isHidden = true
    }
    
    func showDeleteButtonBar() {
        selfView.stageStatusButtonBar.isHidden  = true
        selfView.reviewDeleteButtonBar.isHidden = false
    }
    
    func showCheckButton() {
        self.isEditButtonClicked = false
        selfView.tableView.reloadData()
        refreshTableView(tableView: selfView.tableView)
    }
    
    func hideCheckButton() {
        self.isEditButtonClicked = true
        selfView.tableView.reloadData()
        refreshTableView(tableView: selfView.tableView)
    }
    
//    func showAlertView(style: ) {
//        showAlertView()
//        alertView = AlertView(style: .delete, i: i)
//        contentView.addSubview(alertView)
//
//        alertView.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
//            $0.leading.trailing.bottom.equalToSuperview()
//        }
//
        
//    }
//
//    func hideAlertView() {
//        alertView.removeFromSuperview()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar()
        showNavigationBarBackButton()
        showNavigationBarTrailingButton()
    }
    
    override func setupReload() {
        super.setupReload()
        
        refreshTableView(tableView: selfView.tableView)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.tableView.delegate         = self
        selfView.tableView.dataSource       = self
        selfView.collectionView.delegate    = self
        selfView.collectionView.dataSource  = self
        
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
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.didTapBackButton()
            }
            .disposed(by: disposeBag)
        
        selfView.stageStatusButtonBar.notStartedButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapStageStatusButton(status: .notStarted)
            }
            .disposed(by: disposeBag)
        
        selfView.stageStatusButtonBar.failButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapStageStatusButton(status: .fail)
            }
            .disposed(by: disposeBag)
        
        selfView.stageStatusButtonBar.passButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapStageStatusButton(status: .pass)
            }
            .disposed(by: disposeBag)
        
        selfView.stageStatusButtonBar.editButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapEditButton()
            }
            .disposed(by: disposeBag)
        
        selfView.reviewDeleteButtonBar.editCompleteButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapEditCompleteButton()
            }
            .disposed(by: disposeBag)
        
        selfView.reviewDeleteButtonBar.deleteButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapDeleteButton()
            }
            .disposed(by: disposeBag)
        
        
        isAlertBack { [weak self] _ in
            self?.listener?.tapAlertBackButton()
        }

        
        isAlertNext { [weak self] _ in
            self?.listener?.tapAlertNextButton()
        }
    }
}

extension ApplyEditViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionMockUps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StageTitleCVC.id, for: indexPath) as? StageTitleCVC else { return UICollectionViewCell() }
        

        cell.update(title: collectionMockUps[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? StageTitleCVC else { return }
        
        for cell in collectionView.visibleCells {
            cell.prepareForReuse()
        }
        
        cell.hightlight()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionMockUps[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 20,
                      height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

extension ApplyEditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stageContentList.count
//        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplyEditTVC.id, for: indexPath) as? ApplyEditTVC else {
            return UITableViewCell()
        }
        
        cell.update(content: stageContentList[indexPath.item])
        
//        if isEditButtonClicked {
//            cell.hideCheckButton()
//        } else {
//            cell.showCheckButton()
//        }
//
        cell.selectionStyle = .none
        cell.textChanged {
            [weak tableView] (_) in
            tableView?.snp.updateConstraints {
                $0.height.equalTo(tableView!.contentSize.height)
            }
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log("[D] \(indexPath)")
    }
}
