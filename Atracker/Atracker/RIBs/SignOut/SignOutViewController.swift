//
//  SignOutViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift
import RxGesture
import UIKit
import SnapKit
import GoogleSignIn
import AuthenticationServices

protocol SignOutPresentableAction: AnyObject {
    var tapGoogleButton: Observable<Void> { get }
    var tapAppleButton: Observable<Void> { get }
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
    private let tapAppleButtonSubject = PublishSubject<Void>()
    
    private let googleSignInConfig = GIDConfiguration(clientID: Key.googleClientID)
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        hideNavigationBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.appleSignUpButton.addTarget(self, action: #selector(tapAppleButtonHandler), for: .touchUpInside)
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
        action?.tapAppleButton
            .bind { [weak self] in
                self?.openAppleSignUp()
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
                self?.fetchIdTokenSubject.onNext((SSO.google, authentication.accessToken))
            }
        }
    }
    
    private func openAppleSignUp() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc
    private func tapAppleButtonHandler() {
        tapAppleButtonSubject.onNext(())
    }
}

extension SignOutViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if let authorizationCode = appleIDCredential.authorizationCode, let identityToken = appleIDCredential.identityToken, let authString = String(data: authorizationCode, encoding: .utf8), let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
                fetchIdTokenSubject.onNext((SSO.apple, tokenString))
            }
            
            print("useridentifier: \(userIdentifier)")
            print("fullName: \(fullName)")
            print("email: \(email)")
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Log("[D] 애플 로그인 실패 \(error)")
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
        return tapAppleButtonSubject.asObservable()
    }
}
