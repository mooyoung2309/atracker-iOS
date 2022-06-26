//
//  SignOutViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol SignOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func tapGoogleSignUpButton()
    func tapAppleSignUpButton()
    func tapTestSignUpButton()
}

final class SignOutViewController: BaseNavigationViewController, SignOutPresentable, SignOutViewControllable {
    
    weak var listener: SignOutPresentableListener?
    
    let selfView = SignOutView()
    
    func present(viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
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
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        selfView.googleSignUpButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapGoogleSignUpButton()
            }
            .disposed(by: disposeBag)
        
        selfView.appleSignUpButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapAppleSignUpButton()
            }
            .disposed(by: disposeBag)
        
        selfView.testSignUpButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapTestSignUpButton()
            }
            .disposed(by: disposeBag)
    }
}
