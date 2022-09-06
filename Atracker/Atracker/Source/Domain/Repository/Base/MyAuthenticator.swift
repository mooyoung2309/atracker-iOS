//
//  Authticator.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Foundation
import Alamofire

class MyAuthenticator: Authenticator {
    typealias Credential = MyAuthenticationCredential
    
    func apply(_ credential: Credential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
        urlRequest.addValue(credential.refreshToken, forHTTPHeaderField: "refresh-token")
    }
    
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        response.statusCode == 403
    }
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: Credential) -> Bool {
        // bearerToken의 urlRequest에 대해서만 refresh를 시도 (true)
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
    }
    
    func refresh(_ credential: Credential, for session: Session, completion: @escaping (Result<MyAuthenticationCredential, Error>) -> Void) {
        
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultKey.refreshToken) ?? ""
        let request = TokenRefreshRequest(refreshToken: refreshToken)
        
        AuthRepositoryISOLDCODE.postTokenRefresh(request: request) { response in
            switch response {
            case .success(let data):
                Log("[D] 토큰 리프레시 성공")
                let accessToken = data.accessToken
                UserDefaults.standard.set(accessToken, forKey: UserDefaultKey.accessToken)
                completion(.success(MyAuthenticationCredential(accessToken: accessToken, refreshToken: refreshToken)))
            case .failure(let error):
                Log("[D] 토큰 리프레시 실패")
                completion(.failure(error))
            }
        }
    }
}
