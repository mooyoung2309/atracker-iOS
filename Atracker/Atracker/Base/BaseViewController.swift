//
//  BaseViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    var navigationView = UIView()
    var mainView = UIView()
    var tabView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupReload()
    }
    
    func setupReload() { }
    
    func setupProperty() { }
    
    func setupHierarchy() {
        view.addSubview(navigationView)
        view.addSubview(mainView)
        view.addSubview(tabView)
    }
    
    func setupLayout() {
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
        }
        
        tabView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    func setupBind() { }
    
    func refreshTableView(tableView: UITableView) {
        
        tableView.snp.updateConstraints {
            $0.height.equalTo(CGFloat.greatestFiniteMagnitude)
        }
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.snp.updateConstraints {
            $0.height.equalTo(tableView.contentSize.height)
        }
    }
}
