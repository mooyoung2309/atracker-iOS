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
    var title           = UILabel()
    var backButton      = UIButton()
    var trailingButton  = UIButton()
}

protocol BaseNavigationViewControllerProtocol: AnyObject {
    var statusBar: UIView { get }
    var navigaionBar: NavigationBar { get }
    var containerView: UIView { get }
    var mainView: UIView { get }
    var contentView: UIView { get }
    func setupNavigaionBar()
    func showNavigaionBar(_ bool: Bool)
    func setNavigaionBarTitle(_ text: String)
    func showNavigaionBarBackButton(_ bool: Bool)
    func showNavigaionBarTrailingButton(_ bool: Bool)
    func setNavigaionBarTrailingButtonTitle(_ text: String)
}

class BaseNavigationViewController: BaseViewController, BaseNavigationViewControllerProtocol {
    
    var statusBar       = UIView()
    var navigaionBar    = NavigationBar()
    var containerView   = UIView()
    var mainView        = UIView()
    var contentView     = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigaionBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        showNavigaionBar(false)
        showNavigaionBarBackButton(false)
        showNavigaionBarTrailingButton(false)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(containerView)
        containerView.addSubview(mainView)
        mainView.addSubview(statusBar)
        mainView.addSubview(contentView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        statusBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupNavigaionBar() {
        navigaionBar.backgroundColor = .backgroundGray
        navigaionBar.addShadow(.bottom)
        navigaionBar.title.textColor = .white
        navigaionBar.title.font = .systemFont(ofSize: 16, weight: .regular)
        
        navigaionBar.backButton.setImage(UIImage(named: ImageName.back), for: .normal)
        
        navigaionBar.trailingButton.setTitle("", for: .normal)
        navigaionBar.trailingButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        
        mainView.addSubview(navigaionBar)
        navigaionBar.addSubview(navigaionBar.title)
        navigaionBar.addSubview(navigaionBar.backButton)
        navigaionBar.addSubview(navigaionBar.trailingButton)
        
        navigaionBar.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Size.navigationBarHeight)
        }
        
        navigaionBar.title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        navigaionBar.backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        navigaionBar.trailingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func showNavigaionBar(_ bool: Bool) {
        navigaionBar.alpha = bool ? 1 : 0
    }
    
    func setNavigaionBarTitle(_ text: String) {
        navigaionBar.title.text = text
    }
    
    func showNavigaionBarBackButton(_ bool: Bool) {
        navigaionBar.backButton.alpha = bool ? 1 : 0
    }
    
    func showNavigaionBarTrailingButton(_ bool: Bool) {
        navigaionBar.trailingButton.alpha = bool ? 1 : 0
    }
    
    func setNavigaionBarTrailingButtonTitle(_ text: String) {
        navigaionBar.trailingButton.setTitle(text, for: .normal)
    }
}

