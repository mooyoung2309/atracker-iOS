//
//  BaseViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/29.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

protocol BaseViewControllerProtocol: AnyObject {
    func setupProperty()
    func setupHierarchy()
    func setupLayout()
    func setupBind()
    func refreshTableView(tableView: UITableView)
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundGray
        
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
    
    func setupHierarchy() { }
    
    func setupLayout() { }
    
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
