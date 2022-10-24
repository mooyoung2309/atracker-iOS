//
//  AuthRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/01.
//

import Alamofire
import RxSwift

protocol AuthRepositable {
    func sign(request: SignRequest) -> Observable<SignResponse>
    func signout() -> Observable<VoidModel>
    func postTestSign(request: TestUserRegistrationRequest) -> Observable<SignResponse>
    func postTokenRefresh(request: TokenRefreshRequest) -> Observable<TokenRefreshResponse>
}

class AuthRepository: Repository, AuthRepositable {
    func sign(request: SignRequest) -> Observable<SignResponse> {
        return sendWithNoToken(api: AuthAPI.sign(request))
    }
    
    func signout() -> Observable<VoidModel> {
        return send(api: AuthAPI.signOut)
    }
    
    func postTestSign(request: TestUserRegistrationRequest) -> Observable<SignResponse> {
        return send(api: AuthAPI.testSign(request))
    }
    
    func postTokenRefresh(request: TokenRefreshRequest) -> Observable<TokenRefreshResponse> {
        return send(api: AuthAPI.tokenRefresh(request))
    }
}
