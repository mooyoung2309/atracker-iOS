//
//  AuthService.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/01.
//

import Alamofire
import RxSwift

protocol AuthServicable {
    func sign(request: SignRequest) -> Observable<SignResponse>
    func signOut() -> Observable<VoidModel>
    func logOut()
    func testSign(email: String, gender: String, jobPosition: String, nickName: String, sso: String) -> Observable<SignResponse>
}

class AuthService: AuthServicable {
    let repository: AuthRepository = .init()
    
    func sign(request: SignRequest) -> Observable<SignResponse> {
        return Observable<SignResponse>.create { [weak self] observer in
            self?.repository.sign(request: request)
                .bind { response in
                    UserDefaults.standard.set(response.accessToken, forKey: UserDefaultKey.accessToken)
                    UserDefaults.standard.set(response.refreshToken, forKey: UserDefaultKey.refreshToken)
                    observer.onNext(response)
                }
                .dispose()
            return Disposables.create()
        }
    }
    
    func signOut() -> Observable<VoidModel> {
        return repository.signout()
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.accessToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.refreshToken)
    }
    
    func testSign(email: String, gender: String, jobPosition: String, nickName: String, sso: String) -> Observable<SignResponse> {
        return Observable<SignResponse>.create { [weak self] observer in
            self?.repository.postTestSign(request: .init(email: email, gender: gender, jobPosition: jobPosition, nickName: nickName, sso: sso))
                .bind { response in
                    UserDefaults.standard.set(response.accessToken, forKey: UserDefaultKey.accessToken)
                    UserDefaults.standard.set(response.refreshToken, forKey: UserDefaultKey.refreshToken)
                    observer.onNext(response)
                }
                .dispose()
            return Disposables.create()
        }
    }
}
