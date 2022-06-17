//
//  BaseTabVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class TabBar: UIStackView {
    var title       = UILabel()
    var blogTab     = UIButton()
    var applyTab    = UIButton()
    var planTab     = UIButton()
}

protocol BaseTabViewControllerProtocol: AnyObject {
    var mainView: UIView { get }
    var tabBar: TabBar { get }
}

class BaseTabViewController: BaseViewController, BaseTabViewControllerProtocol {
    
    var mainView        = UIView()
    var tabBar          = TabBar()
    
    override func setupProperty() {
        super.setupProperty()
        
        tabBar.backgroundColor = .backgroundGray
        tabBar.distribution = .fillEqually
        tabBar.blogTab.setImage(UIImage(named: ImageName.user), for: .normal)
        tabBar.applyTab.setImage(UIImage(named: ImageName.home), for: .normal)
        tabBar.planTab.setImage(UIImage(named: ImageName.user), for: .normal)
        tabBar.addArrangedSubviews([tabBar.blogTab, tabBar.applyTab, tabBar.planTab])
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(mainView)
        view.addSubview(tabBar)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
        
        tabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
