//
//  SignUpSuccessViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpSuccessPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SignUpSuccessViewController: BaseNavigationViewController, SignUpSuccessPresentable, SignUpSuccessViewControllable {

    weak var listener: SignUpSuccessPresentableListener?
    
    let selfView = SignUpSuccessView()
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        hideNavigationBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: LoggedInViewControllable

//extension SignUpSuccessViewController: SignInViewControllable {
//    func present(viewController: ViewControllable) {
//        viewController.uiviewController.modalPresentationStyle = .fullScreen
//        present(viewController.uiviewController, animated: false, completion: nil)
//    }
//    
//    func 
//}
