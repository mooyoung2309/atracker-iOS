//
//  BaseNavigationViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class NavigationBar: UIView {
    var title = UILabel()
    var backButton = UIButton()
}

protocol BaseNavigationViewControllerProtocol: AnyObject {
    var statusBar: UIView { get }
    var navigaionBar: NavigationBar { get }
    var mainView: UIView { get }
    func setupNavigaionBar()
    func showNavigaionBar(_ bool: Bool)
    func setTitle(_ text: String)
    func showBackButton(_ bool: Bool)
}

class BaseNavigationViewController: BaseViewController, BaseNavigationViewControllerProtocol {
    var statusBar       = UIView()
    var navigaionBar    = NavigationBar()
    var mainView        = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        navigaionBar.backgroundColor = .backgroundGray
        
        showNavigaionBar(false)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(statusBar)
        view.addSubview(mainView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        statusBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Size.statusBarHeight)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.statusBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
    }
    
    func setupNavigaionBar() {
        navigaionBar.title.textColor = .white
        navigaionBar.title.font = .systemFont(ofSize: 16, weight: .regular)
        
        navigaionBar.backButton.setImage(UIImage(named: ImageName.back), for: .normal)
        view.addSubview(navigaionBar)
        navigaionBar.addSubview(navigaionBar.title)
        navigaionBar.addSubview(navigaionBar.backButton)
        
        navigaionBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Size.navigationBarHeight)
        }
        
        navigaionBar.title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        navigaionBar.backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(23)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
    }
    
    func showNavigaionBar(_ bool: Bool) {
        navigaionBar.alpha = bool ? 1 : 0
    }
    
    func setTitle(_ text: String) {
        navigaionBar.title.text = text
    }
    
    func showBackButton(_ bool: Bool) {
        navigaionBar.backButton.alpha = bool ? 1 : 0
    }
}

