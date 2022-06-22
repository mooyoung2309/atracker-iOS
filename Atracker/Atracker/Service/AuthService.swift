//
//  AuthService.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Alamofire

protocol AuthServiceProtocol {
    func testSignUp(email: String, gender: String, jobPosition: String, nickName: String, sso: String, completion: @escaping (Result<SignResponse, Error>) -> Void)
}

class AuthService: AuthServiceProtocol {
    let authRepository = AuthRepository()
    
    func testSignUp(email: String, gender: String, jobPosition: String, nickName: String, sso: String, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        authRepository.postTestSign(request: .init(email: email, gender: gender, jobPosition: jobPosition, nickName: nickName, sso: sso)) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
