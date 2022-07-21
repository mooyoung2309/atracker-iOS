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
    var fetchIdToken: Observable<(SSO, String)> { get }
}

protocol SignOutPresentableHandler: AnyObject {

}

protocol SignOutPresentableListener: AnyObject {
    
}

final class SignOutViewController: BaseNavigationViewController, SignOutPresentable, SignOutViewControllable {
    
    weak var listener: SignOutPresentableListener?
    weak var action: SignOutPresentableAction? {
        return self
    }
    weak var handler: SignOutPresentableHandler?
    
    let selfView = SignOutView()
    
    private let fetchIdTokenSubject = PublishSubject<(SSO, String)>()
    private let fetchSSOSubject = PublishSubject<SSO>()
    
    private let googleSignInConfig = GIDConfiguration(clientID: Key.googleClientID)
    
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
        
        // 바인딩 액션
        action?.tapGoogleButton
            .bind { [weak self] in
                self?.openGoogleSignUp()
            }
            .disposed(by: disposeBag)
    }
    
    private func openGoogleSignUp() {
        GIDSignIn.sharedInstance.signIn(with: googleSignInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            user.authentication.do { [weak self] authentication, error in
                guard error == nil else { Log("[D] 구글 로그인 에러 \(error)"); return }
                guard let authentication = authentication else { return }
                
                if let idToken = authentication.idToken {
                    self?.fetchIdTokenSubject.onNext((SSO.google, idToken))
                }
            }
        }
    }
}

extension SignOutViewController: SignOutPresentableAction {
    var fetchIdToken: Observable<(SSO, String)> {
        return fetchIdTokenSubject.asObservable()
    }
    
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
