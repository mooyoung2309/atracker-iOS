//
//  ApplicationReviewEditVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class ApplyEditVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    let viewModel = ApplyEditVM()
    let selfView = ApplyEditView()
    var mockupContents = Const.Test.Applys
    let mockupTypes = ["서류", "사전과제", "1차 면접", "2차 면접", "인적성"]
    var applies: [Apply] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        refreshTableView(tableView: selfView.tableView)
    }
    
    override func setupProperty() {
        super.setupProperty()
        view.backgroundColor = .backgroundGray
        title = "카카오뱅크"
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        selfView.collectionView.delegate = self
        selfView.collectionView.dataSource = self
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        view.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        selfView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setupBind() {
        selfView.editButton.rx.tap
            .map { true }
            .bind(to: viewModel.input.isClickEditButton)
            .disposed(by: disposeBag)
        
        selfView.plusQAButton.rx.tap
            .map { true }
            .bind(to: viewModel.input.isClickPlusQAButton)
            .disposed(by: disposeBag)
        
        selfView.plusReviewButton.rx.tap
            .map { true }
            .bind(to: viewModel.input.isClickPlusReviewButton)
            .disposed(by: disposeBag)
        
        viewModel.output.isClickedEditButton
            .withUnretained(self)
            .bind { owner, bool in
                owner.isClickedEditButton(bool)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.testApplies
            .withUnretained(self)
            .bind { owner, _ in
                owner.refreshTableView(tableView: owner.selfView.tableView)
            }
            .disposed(by: disposeBag)
    }   
//        let deleteAlertVC = AlertViewController(titleImage: UIImage(systemName: "star"), defaultTitle: "테스트", highlightTitle: "테스트", subTitle: "서브 타이틀", buttonTitles: ["확인", "취소"])
        //        deleteAlertVC.modalPresentationStyle = .overFullScreen
        
        //        navigationController?.present(deleteAlertVC, animated: true, completion: nil)
}


// MARK: 커스텀 메소드
extension ApplyEditVC {
    func addApplyContent(apply: Apply) {
        selfView.tableView.insertRows(at: [IndexPath(row: applies.count - 1, section: 0)], with: .automatic)
        refreshTableView(tableView: selfView.tableView)
    }
    
    func isClickedEditButton(_ bool: Bool) {
        let cells = selfView.tableView.visibleCells
        if cells.count > 0 {
            for cell in cells {
                guard let reviewContentTVC = cell as? ApplyContentTVC else { return }
                reviewContentTVC.showCheckButton(bool)
            }
            selfView.tableView.performBatchUpdates(nil)
        }
        
        if bool {
            selfView.contentTypeButtonStackView.isHidden = true
            selfView.deleteButtonStackView.isHidden = false
        } else {
            selfView.contentTypeButtonStackView.isHidden = false
            selfView.deleteButtonStackView.isHidden = true
        }
    }
}

extension ApplyEditVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockupTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case selfView.collectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApplyContentTypeCVC.id, for: indexPath) as? ApplyContentTypeCVC else { return UICollectionViewCell() }
            
            cell.update(title: mockupTypes[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
}

extension ApplyEditVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.testApplies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case selfView.tableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplyContentTVC.id, for: indexPath) as? ApplyContentTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.update(apply: viewModel.output.testApplies.value[indexPath.row])
            cell.textChanged {
                [weak tableView] (_) in
                tableView?.snp.updateConstraints {
                    $0.height.equalTo(tableView!.contentSize.height)
                }
                tableView?.beginUpdates()
                tableView?.endUpdates()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
