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

protocol TabBarPresentableAction: AnyObject {
    var tapTabBar: Observable<Int> { get }
}

protocol TabBarPresentableHandler: AnyObject {
    var selectedIndex: Observable<Int> { get }
}

protocol TabBarPresentableListener: AnyObject {

}

final class TabBarViewController: UITabBarController, TabBarPresentable, TabBarViewControllable {
    weak var listener: TabBarPresentableListener?
    
    var action: TabBarPresentableAction? {
        return self
    }
    var handler: TabBarPresentableHandler?
    
    private var disposeBag = DisposeBag()
    
    private let tapTabBarSubject = PublishSubject<Int>()
    
    func setupTabBar(blogViewController: UIViewController, applyViewController: UIViewController, myPageViewController: UIViewController, scheduleViewController: UIViewController) {
        
        blogViewController.tabBarItem = UITabBarItem(title: "블로그", image: UIImage(named: ImageName.search)?.withTintColor(.white), tag: 0)
        applyViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: ImageName.home)?.withTintColor(.white), tag: 1)
        myPageViewController.tabBarItem = UITabBarItem(title: "마이", image: UIImage(named: ImageName.user)?.withTintColor(.white), tag: 2)
        
        // FIXME: 다음 버전 출시
//        scheduleViewController.tabBarItem = UITabBarItem(title: "스케쥴", image: UIImage(named: ImageName.user)?.withTintColor(.white), tag: 3)
        
        self.viewControllers = [UINavigationController(rootViewController: blogViewController), UINavigationController(rootViewController: applyViewController), UINavigationController(rootViewController: myPageViewController)]
        
        tapTabBarSubject.onNext(1)
        selectedIndex = 1
    }
    
    func present(_ viewController: ViewControllable, isTabBarShow: Bool) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        present(viewController.uiviewController, animated: false, completion: nil)
    }
    
    func dismiss(_ rootViewController: ViewControllable?, isTabBarShow: Bool) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBind()
    }
    
    func setupBind() {
        guard let handler = handler else { return }

        handler.selectedIndex
            .bind { [weak self] i in
                self?.selectedIndex = i
            }
            .disposed(by: disposeBag)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tapTabBarSubject.onNext(item.tag)
    }
}

extension TabBarViewController: TabBarPresentableAction {
    var tapTabBar: Observable<Int> {
        return tapTabBarSubject.asObservable()
    }
}


//final class TabBarViewController: BaseTabViewController, UITabBarControllerDelegate, TabBarPresentable, TabBarViewControllable {
//    var thisView: UIView {
//        return mainView
//    }
//
//    weak var listener: TabBarPresentableListener?
//
//    func present(viewController: ViewControllable) {
//        viewController.uiviewController.modalPresentationStyle = .fullScreen
//        present(viewController.uiviewController, animated: false, completion: nil)
//    }
//
//    func dismiss(viewController: ViewControllable) {
//        if presentedViewController === viewController.uiviewController {
//            dismiss(animated: false, completion: nil)
//        }
//    }
//
//    func selectBlogButton() {
//        tabBar.blogTab.isSelected       = true
//        tabBar.applyTab.isSelected      = false
//        tabBar.scheduleTab.isSelected   = false
//    }
//
//    func selectApplyButton() {
//        tabBar.blogTab.isSelected       = false
//        tabBar.applyTab.isSelected      = true
//        tabBar.scheduleTab.isSelected   = false
//    }
//
//    func selectScheduleButton() {
//        tabBar.blogTab.isSelected       = false
//        tabBar.applyTab.isSelected      = false
//        tabBar.scheduleTab.isSelected   = true
//    }
//
//    func showTabBar() {
//        tabBar.isHidden = false
//    }
//
//    func hideTabBar() {
//        tabBar.isHidden = true
//    }
//
//    override func setupBind() {
//        super.setupBind()
//
//        tabBar.blogTab.rx.tap
//            .subscribe(onNext: { [weak self] _ in
//                self?.listener?.tabBlogButton()
//            })
//            .disposed(by: disposeBag)
//
//        tabBar.applyTab.rx.tap
//            .subscribe(onNext: { [weak self] _ in
//                self?.listener?.tabApplyButton()
//            })
//            .disposed(by: disposeBag)
//
//        tabBar.scheduleTab.rx.tap
//            .subscribe(onNext: { [weak self] _ in
//                self?.listener?.tabScheduleButton()
//            })
//            .disposed(by: disposeBag)
//    }
//}
