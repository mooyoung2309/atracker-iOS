//
//  AuthService.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Alamofire

protocol AuthServiceProtocolISOLDCODE {
    func sign(request: SignRequest, completion: @escaping (Result<SignResponse, Error>) -> Void)
    func signOut(completion: @escaping (Result<(Bool), Error>) -> Void)
    func logOut()
    func testSignUp(email: String, gender: String, jobPosition: String, nickName: String, sso: String, completion: @escaping (Result<SignResponse, Error>) -> Void)
}

class AuthServiceISOLDCODE: AuthServiceProtocolISOLDCODE {
    func sign(request: SignRequest, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        AuthRepositoryISOLDCODE.sign(request: request) { result in
            switch result {
            case .success(let data):
                UserDefaults.standard.set(data.accessToken, forKey: UserDefaultKey.accessToken)
                UserDefaults.standard.set(data.refreshToken, forKey: UserDefaultKey.refreshToken)
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signOut(completion: @escaping (Result<(Bool), Error>) -> Void) {
        AuthRepositoryISOLDCODE.signout { [weak self] result in
            switch result {
            case .success(let data):
                self?.logOut()
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.accessToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.refreshToken)
    }
    
    func testSignUp(email: String, gender: String, jobPosition: String, nickName: String, sso: String, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        AuthRepositoryISOLDCODE.postTestSign(request: .init(email: email, gender: gender, jobPosition: jobPosition, nickName: nickName, sso: sso)) { result in
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
