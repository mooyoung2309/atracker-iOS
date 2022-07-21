//
//  AuthRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation
import Alamofire

protocol AuthRepositoryProtocol {
    func sign(request: SignRequest, completion: @escaping (Result<SignResponse, Error>) -> Void)
    func postTestSign(request: TestUserRegistrationRequest, completion: @escaping (Result<SignResponse, Error>) -> Void)
}

class AuthRepository {
    func sign(request: SignRequest, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        AF.request(AuthAPI.sign(request)).responseDecodable { (response: AFDataResponse<SignResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postTestSign(request: TestUserRegistrationRequest, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        
        AF.request(AuthAPI.testSign(request)).responseDecodable { (response: AFDataResponse<SignResponse>) in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    static func postTokenRefresh(request: TokenRefreshRequest, completion: @escaping (Result<TokenRefreshResponse, Error>) -> Void) {
        
        AF.request(AuthAPI.tokenRefresh(request)).responseDecodable { (response: AFDataResponse<TokenRefreshResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
