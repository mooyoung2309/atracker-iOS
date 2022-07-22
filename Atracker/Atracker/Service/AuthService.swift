//
//  AuthService.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Alamofire

protocol AuthServiceProtocol {
    func sign(request: SignRequest, completion: @escaping (Result<SignResponse, Error>) -> Void)
    func testSignUp(email: String, gender: String, jobPosition: String, nickName: String, sso: String, completion: @escaping (Result<SignResponse, Error>) -> Void)
}

class AuthService: AuthServiceProtocol {
    let authRepository = AuthRepository()
    
    func sign(request: SignRequest, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        AuthRepository.shared.sign(request: request) { result in
            switch result {
            case .success(let data):
                UserDefaults.standard.set(data.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(data.refreshToken, forKey: "refreshToken")
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signOut() {
        UserDefaults.standard.string(forKey: UserDefaultKey.accessToken)
    }
    
    func testSignUp(email: String, gender: String, jobPosition: String, nickName: String, sso: String, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        authRepository.postTestSign(request: .init(email: email, gender: gender, jobPosition: jobPosition, nickName: nickName, sso: sso)) { result in
            switch result {
            case .success(let data):
                UserDefaults.standard.set(data.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(data.refreshToken, forKey: "refreshToken")
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
