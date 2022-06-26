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
    func tabBlogButton()
    func tabApplyButton()
    func tabScheduleButton()
}

final class TabBarViewController: BaseTabViewController, UITabBarControllerDelegate, TabBarPresentable, TabBarViewControllable {
    var thisView: UIView {
        return mainView
    }
    
    weak var listener: TabBarPresentableListener?
    
    func present(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        present(viewController.uiviewController, animated: false, completion: nil)
    }

    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: false, completion: nil)
        }
    }
    
    func selectBlogButton() {
        tabBar.blogTab.isSelected       = true
        tabBar.applyTab.isSelected      = false
        tabBar.scheduleTab.isSelected   = false
    }
    
    func selectApplyButton() {
        tabBar.blogTab.isSelected       = false
        tabBar.applyTab.isSelected      = true
        tabBar.scheduleTab.isSelected   = false
    }
    
    func selectScheduleButton() {
        tabBar.blogTab.isSelected       = false
        tabBar.applyTab.isSelected      = false
        tabBar.scheduleTab.isSelected   = true
    }
    
    func showTabBar() {
        tabBar.isHidden = false
    }
    
    func hideTabBar() {
        tabBar.isHidden = true
    }

    override func setupBind() {
        super.setupBind()

        tabBar.blogTab.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.tabBlogButton()
            })
            .disposed(by: disposeBag)

        tabBar.applyTab.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.tabApplyButton()
            })
            .disposed(by: disposeBag)

        tabBar.scheduleTab.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.tabScheduleButton()
            })
            .disposed(by: disposeBag)
    }
}
