//
//  CustomTabBarViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/23.
//

import UIKit
import RxSwift

class CustomTabBarController: UITabBarController {
    
    let customTabBar = CustomTabBar()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
        bind()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    private func setupHierarchy() {
        view.addSubview(customTabBar)
    }
    
    private func setupLayout() {
        customTabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(0)
            $0.height.equalTo(70)
        }
    }
    
    private func setupProperties() {
        tabBar.isHidden = true
        
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.addShadow()
        
        selectedIndex = 0
        let controllers = CustomTabItem.allCases.map { $0.viewController }
        setViewControllers(controllers, animated: true)
    }
    
    private func selectTabWith(index: Int) {
        self.selectedIndex = index
    }
    
    //MARK: - Bindings
    
    private func bind() {
        customTabBar.itemTapped
            .bind { [weak self] in self?.selectTabWith(index: $0) }
            .disposed(by: disposeBag)
    }
}
