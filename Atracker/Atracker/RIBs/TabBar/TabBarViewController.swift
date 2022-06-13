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

final class TabBarViewController: BaseTabViewController, UITabBarControllerDelegate, TabBarPresentable, TabBarViewControllable {
    var contentView: UIView {
        return mainView
    }
    
    weak var listener: TabBarPresentableListener?
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }

    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: false, completion: nil)
        }
    }

    override func setupBind() {
        super.setupBind()

        tabBar.blogTab.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.didTabBlog()
            })
            .disposed(by: disposeBag)

        tabBar.applyTab.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.didTabApply()
            })
            .disposed(by: disposeBag)

        tabBar.planTab.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.didTabPlan()
            })
            .disposed(by: disposeBag)
    }
}
