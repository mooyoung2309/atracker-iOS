//
//  TabBarViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import RxSwift
import UIKit
import Then
import SnapKit

protocol TabBarPresentableListener: AnyObject {
    func didTabBlog()
    func didTabApply()
    func didTabPlan()
}

final class TabBarViewController: BaseViewController, UITabBarControllerDelegate, TabBarPresentable, TabBarViewControllable {
    var contentView: UIView {
        return mainView
    }
    
    weak var listener: TabBarPresentableListener?
    
    let tabBarStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }
    let tabBlog = UIButton(type: .system).then {
        $0.setTitle("블로그 탭", for: .normal)
    }
    let tabApply = UIButton(type: .system).then {
        $0.setTitle("지원 탭", for: .normal)
    }
    let tabPlan = UIButton(type: .system).then {
        $0.setTitle("일정 탭", for: .normal)
    }
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }

    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: false, completion: nil)
        }
    }

    override func setupProperty() {
        super.setupProperty()

        tabBarStackView.backgroundColor = .purple
        tabBarStackView.addArrangedSubviews([tabBlog, tabApply, tabPlan])
        
        tabView = tabBarStackView
        
        mainView.backgroundColor = .neonGreen
        navigationView.backgroundColor = .red
        tabView.backgroundColor = .blue4
    }

    override func setupHierarchy() {
        super.setupHierarchy()

    }

    override func setupLayout() {
        super.setupLayout()
        
    }

    override func setupBind() {
        super.setupBind()

        tabBlog.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.didTabBlog()
            })
            .disposed(by: disposeBag)

        tabApply.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.didTabApply()
            })
            .disposed(by: disposeBag)

        tabPlan.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.didTabPlan()
            })
            .disposed(by: disposeBag)
    }
}
