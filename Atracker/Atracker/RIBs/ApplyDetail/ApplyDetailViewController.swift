//
//  ApplyDetailViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol ApplyDetailPresentableListener: AnyObject {
    func tapBackButton()
    func tapEditButton()
    func tapEditApplyOverallButton()
    func tapEditApplyStageProgressButton()
    func tapDeleteApplyButton()
}

final class ApplyDetailViewController: BaseNavigationViewController, ApplyDetailPresentable, ApplyDetailViewControllable {
    
    var thisView: UIView {
        return containerView
    }

    weak var listener: ApplyDetailPresentableListener?
    
    let selfView = ApplyDetailView()
    let mockUps = 0...30
    let editTypes = ["지원 후기 수정하기", "전형 편집하기", "지원 후기 삭제하기"]
    
    private var apply: Apply?
    
    func showEditTableView() {
        selfView.showEditTableView()
    }
    
    func hideEditTableView() {
        selfView.hideEditTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        refreshTableView(tableView: selfView.tableView)
        refreshTableView(tableView: selfView.editTableView)
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        showNavigationBar()
        showNavigationBarBackButton()
        showNavigationBarTrailingButton()
        setNavigationBarTrailingButtonImage(UIImage(named: ImageName.more))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        selfView.editTableView.delegate = self
        selfView.editTableView.dataSource = self
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
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
  
        navigaionBar.trailingButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapEditButton()
            }
            .disposed(by: disposeBag)
    }
}

extension ApplyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case selfView.tableView:
            return mockUps.count
        case selfView.editTableView:
            return editTypes.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case selfView.tableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplyDetailTVC.id, for: indexPath) as? ApplyDetailTVC else { return UITableViewCell() }
            cell.update()
            cell.selectionStyle = .none
            return cell
        case selfView.editTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EditTypeTVC.id, for: indexPath) as? EditTypeTVC else { return UITableViewCell() }
            cell.update(image: UIImage(named: ImageName.trash), title: editTypes[indexPath.item])
            let tmpView = UIView()
            tmpView.backgroundColor = .gray6
            cell.selectedBackgroundView = tmpView
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log(indexPath.row)
        switch tableView {
        case selfView.editTableView:
            if indexPath.row == 0 {
                listener?.tapEditApplyOverallButton()
            } else if indexPath.row == 1 {
                listener?.tapEditApplyStageProgressButton()
            } else if indexPath.row == 2 {
                listener?.tapDeleteApplyButton()
            }
            return
        default:
            return
        }
    }
}
