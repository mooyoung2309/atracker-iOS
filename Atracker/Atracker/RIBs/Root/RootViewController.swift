//
//  RootViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    weak var listener: RootPresentableListener?
    
    func present(_ viewController: ViewControllable, isTabBarShow: Bool) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        present(viewController.uiviewController, animated: false, completion: nil)
    }
    
    func dismiss(_ rootViewController: ViewControllable?, isTabBarShow: Bool) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .backgroundGray
    }
}

// MARK: SignInViewControllable

extension RootViewController: SignInViewControllable {

}
