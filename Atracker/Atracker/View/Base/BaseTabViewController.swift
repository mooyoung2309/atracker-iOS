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
    var title           = UILabel()
    var blogTab         = UIButton(type: .custom)
    var applyTab        = UIButton(type: .custom)
    var scheduleTab     = UIButton(type: .custom)
}

protocol BaseTabViewControllerProtocol: AnyObject {
    var mainView: UIView { get }
    var tabBar: TabBar { get }
}

class BaseTabViewController: BaseViewController, BaseTabViewControllerProtocol {
    
    var mainView        = UIView()
    var tabBar          = TabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.blogTab.alignVertical(spacing: 2)
        tabBar.applyTab.alignVertical(spacing: 2)
        tabBar.scheduleTab.alignVertical(spacing: 2)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        tabBar.backgroundColor = .backgroundGray
        tabBar.distribution = .fillEqually
        tabBar.addShadow(.top)
        
        tabBar.blogTab.setImage(UIImage(named: ImageName.search)?.withTintColor(.gray3), for: .normal)
        tabBar.blogTab.setImage(UIImage(named: ImageName.search)?.withTintColor(.white), for: .selected)
        tabBar.blogTab.setImage(UIImage(named: ImageName.search)?.withTintColor(.white), for: .highlighted)
        tabBar.blogTab.setTitle("탐색", for: .normal)
        tabBar.blogTab.setTitleColor(.gray3, for: .normal)
        tabBar.blogTab.setTitleColor(.white, for: .selected)
        tabBar.blogTab.setTitleColor(.white, for: .selected)
        tabBar.blogTab.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        
        tabBar.applyTab.setImage(UIImage(named: ImageName.home)?.withTintColor(.gray3), for: .normal)
        tabBar.applyTab.setImage(UIImage(named: ImageName.home)?.withTintColor(.white), for: .selected)
        tabBar.applyTab.setImage(UIImage(named: ImageName.home)?.withTintColor(.white), for: .highlighted)
        tabBar.applyTab.setTitle("홈", for: .normal)
        tabBar.applyTab.setTitleColor(.gray3, for: .normal)
        tabBar.applyTab.setTitleColor(.white, for: .selected)
        tabBar.applyTab.setTitleColor(.white, for: .highlighted)
        tabBar.applyTab.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        
        tabBar.scheduleTab.setImage(UIImage(named: ImageName.calendar)?.withTintColor(.gray3), for: .normal)
        tabBar.scheduleTab.setImage(UIImage(named: ImageName.calendar)?.withTintColor(.white), for: .selected)
        tabBar.scheduleTab.setImage(UIImage(named: ImageName.calendar)?.withTintColor(.white), for: .highlighted)
        tabBar.scheduleTab.setTitle("일정", for: .normal)
        tabBar.scheduleTab.setTitleColor(.gray3, for: .normal)
        tabBar.scheduleTab.setTitleColor(.white, for: .selected)
        tabBar.scheduleTab.setTitleColor(.white, for: .highlighted)
        tabBar.scheduleTab.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        tabBar.addArrangedSubviews([tabBar.blogTab, tabBar.applyTab, tabBar.scheduleTab])
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
