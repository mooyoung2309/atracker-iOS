//
//  ApplicationViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit

class ApplyVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    let viewModel = ApplyVM()
    let selfView = ApplyView()
    let mockUps = ["이소진 1", "이소진 2", "이소진 3", "이소진 4", "이소진 5", "이소진 6", "이소진 7", "이소진 8"]
    
    override func setupReload() {
        view.backgroundColor = .backgroundGray
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.barTintColor = .backgroundGray
        tabBarController?.tabBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(true, animated: false)
        refreshTableView(tableView: selfView.tableView)
    }
    
    override func setupProperty() {
        super.setupProperty()
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
        super.setupBind()
        selfView.plusButton.rx.tap
        .withUnretained(self)
        .bind { owner, _ in
            let applicationReviewEditVC = ApplyEditVC()
            owner.navigationController?.pushViewController(applicationReviewEditVC, animated: true)
        }
        .disposed(by: disposeBag)
    }
}
extension ApplyVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockUps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case selfView.tableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplyProgressTVC.id, for: indexPath) as? ApplyProgressTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.update(mokUp: mockUps[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}
