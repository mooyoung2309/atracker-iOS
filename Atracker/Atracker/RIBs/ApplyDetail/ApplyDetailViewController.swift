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
}

final class ApplyDetailViewController: BaseNavigationViewController, ApplyDetailPresentable, ApplyDetailViewControllable {
    var thisView: UIView {
        return containerView
    }

    weak var listener: ApplyDetailPresentableListener?
    
    let selfView = ApplyDetailView()
    let mockUps = 0...30
    
    private var apply: Apply?
    
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
        
        selfView.tableView.delegate     = self
        selfView.tableView.dataSource   = self
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
        
        selfView.editButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapEditButton()
            }
            .disposed(by: disposeBag)
    }
}

extension ApplyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockUps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplyDetailTVC.id, for: indexPath) as? ApplyDetailTVC else { return UITableViewCell() }
        
        cell.update()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log(indexPath.row)
    }
}
