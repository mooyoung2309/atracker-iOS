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

class BaseVC: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
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
