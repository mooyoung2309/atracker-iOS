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
import GoogleSignIn

protocol SignOutPresentableAction: AnyObject {
    var tapGoogleButton: Observable<Void> { get }
    var tapAppleButton: Observable<Void> { get }
    var tapTestButton: Observable<Void> { get }
}

protocol SignOutPresentableHandler: AnyObject {
    
}

protocol SignOutPresentableListener: AnyObject {
    func signUp(idToken: String)
}

final class SignOutViewController: BaseNavigationViewController, SignOutPresentable, SignOutViewControllable {
    
    weak var listener: SignOutPresentableListener?
    weak var action: SignOutPresentableAction? {
        return self
    }
    weak var handler: SignOutPresentableHandler?
    
    let selfView = SignOutView()
    
    private let googleSignInConfig = GIDConfiguration(clientID: Key.googleClientID)
    
//    func present(viewController: UIViewController) {
//        viewController.modalPresentationStyle = .fullScreen
//        present(viewController, animated: true, completion: nil)
//    }
    
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

    }
    
    private func tmp() {
        GIDSignIn.sharedInstance.signIn(with: googleSignInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            user.authentication.do { [weak self] authentication, error in
                guard error == nil else { Log("[D] 구글 로그인 에러 \(error)"); return }
                guard let authentication = authentication else { return }
                
                let idToken = authentication.idToken
                
                Log("[D] \(idToken)")
            }
            
        }
    }
}

extension SignOutViewController: SignOutPresentableAction {
    var tapGoogleButton: Observable<Void> {
        return selfView.googleSignUpButton.rx.tap.asObservable()
    }
    
    var tapAppleButton: Observable<Void> {
        return selfView.appleSignUpButton.rx.tap.asObservable()
    }
    
    var tapTestButton: Observable<Void> {
        return selfView.testSignUpButton.rx.tap.asObservable()
    }
}
