//
//  BaseNavigationViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class NavigationBar: UIView {
    var title = UILabel()
    var backButton = UIButton()
    var trailingButton = UIButton()
}

extension UITabBar {
func tabsVisiblty(_ isVisiblty: Bool = true){
    if isVisiblty {
        self.isHidden = false
        self.layer.zPosition = 0
    } else {
        self.isHidden = true
        self.layer.zPosition = -1
    }
}
}

protocol BaseNavigationViewControllerProtocol: AnyObject {
    var statusBar: UIView { get }
    var navigaionBar: NavigationBar { get }
    var contentView: UIView { get }
    
    func setupNavigaionBar()
    func showNavigationBar()
    func hideNavigationBar()
    func setNavigaionBarTitle(_ text: String)
    func showNavigationBarBackButton()
    func hideNavigationBarBackButton()
    func showNavigationBarTrailingButton()
    func hideNavigationBarTrailingButton()
    func setNavigationBarTrailingButtonTitle(_ text: String)
    func setNavigationBarTrailingButtonImage(_ image: UIImage?)
    func hideNavigationBarShadow()
}

class BaseNavigationViewController: BaseViewController, BaseNavigationViewControllerProtocol {
    var contentView = UIView()
    var statusBar = UIView()
    var navigaionBar = NavigationBar()
    
    var alertView = AlertView()
    var blurView = UIView()
    
    var isAlertBack: ((Bool) -> Void)?
    var isAlertNext: ((Bool) -> Void)?
    
    func present(_ viewController: ViewControllable, isTabBarShow: Bool) {
        Log("[D] 화면 전환됨")
        tabBarController?.tabBar.isHidden = !isTabBarShow
        tabBarController?.tabBar.layer.zPosition = isTabBarShow ? 0 : -1
        navigationController?.pushViewController(viewController.uiviewController, animated: true)
        
    }
    
    func dismiss(_ rootViewController: ViewControllable? = nil, isTabBarShow: Bool) {
        tabBarController?.tabBar.isHidden = !isTabBarShow
        tabBarController?.tabBar.layer.zPosition = isTabBarShow ? 0 : -1
        if let rootViewController = rootViewController {
            navigationController?.popToViewController(rootViewController.uiviewController, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlertView(style: AlertStyle) {
        alertView.update(style: style)
        
        view.addSubview(alertView)
        
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        alertView.isAlertBack { [weak self] _ in
            Log("[D] 경고창 왼쪽 버튼")
            self?.isAlertBack?(true)
        }
        
        alertView.isAlertNext { [weak self] _ in
            Log("[D] 경고창 오른쪽 버튼")
            self?.isAlertNext?(true)
        }
    }
    
    func hideAlertView() {
        alertView.removeFromSuperview()
    }
    
    func showBlurView() {
        view.addSubview(blurView)
        
        blurView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func hideBlurView() {
        blurView.removeFromSuperview()
    }
    
    func hideNavigationBarShadow() {
        navigaionBar.addShadow(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigaionBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
        navigaionBar.addShadow(.bottom)
        navigaionBar.title.textColor = .white
        navigaionBar.title.font = .systemFont(ofSize: 16, weight: .regular)
        
        navigaionBar.backButton.setImage(UIImage(named: ImageName.back), for: .normal)
        
        navigaionBar.trailingButton.setTitle("", for: .normal)
        navigaionBar.trailingButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(statusBar)
        view.addSubview(contentView)
        view.addSubview(navigaionBar)
        
        navigaionBar.addSubview(navigaionBar.title)
        navigaionBar.addSubview(navigaionBar.backButton)
        navigaionBar.addSubview(navigaionBar.trailingButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        statusBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
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
    
    func setupNavigaionBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showNavigationBar() {
        navigaionBar.alpha = 1
        statusBar.backgroundColor = .backgroundLightGray
        navigaionBar.backgroundColor = .backgroundLightGray
    }
    
    func hideNavigationBar() {
        navigaionBar.alpha = 0
        statusBar.backgroundColor = .clear
        navigaionBar.backgroundColor = .backgroundGray
    }
    
    func setNavigaionBarTitle(_ text: String) {
        navigaionBar.title.text = text
    }
    
    func showNavigationBarBackButton() {
        navigaionBar.backButton.alpha = 1
    }
    
    func hideNavigationBarBackButton() {
        navigaionBar.backButton.alpha = 0
    }
    
    func showNavigationBarTrailingButton() {
        navigaionBar.trailingButton.alpha = 1
    }
    
    func hideNavigationBarTrailingButton() {
        navigaionBar.trailingButton.alpha = 0
    }
    
    func setNavigationBarTrailingButtonTitle(_ text: String) {
        navigaionBar.trailingButton.setTitle(text, for: .normal)
    }
    
    func setNavigationBarTrailingButtonImage(_ image: UIImage?) {
        navigaionBar.trailingButton.setImage(image, for: .normal)
    }
    
    func isAlertBack(completion: @escaping (Bool) -> Void) {
        self.isAlertBack = completion
    }
    
    func isAlertNext(completion: @escaping (Bool) -> Void) {
        self.isAlertNext = completion
    }
}
