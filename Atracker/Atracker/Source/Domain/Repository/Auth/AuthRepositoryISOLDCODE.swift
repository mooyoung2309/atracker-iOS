//
//  AuthRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Alamofire

protocol AuthRepositoryProtocolISOLDCDE {
    static func sign(request: SignRequest, completion: @escaping (Result<SignResponse, Error>) -> Void)
    static func signout(completion: @escaping (Result<(Bool), Error>) -> Void)
    static func postTestSign(request: TestUserRegistrationRequest, completion: @escaping (Result<SignResponse, Error>) -> Void)
}

class AuthRepositoryISOLDCODE: AuthRepositoryProtocolISOLDCDE {
    static func sign(request: SignRequest, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        AF.request(AuthAPI.sign(request)).responseDecodable { (response: AFDataResponse<SignResponse>) in
            print(response.data)
            print(response.response)
            print(response.result)
            print(response.error)
            print(response.request)
            print(response.debugDescription)
            print(response.description)
            print(response.value)
            switch response.result {
            case .success(let data):
                Log("[D] 회원가입 성공 \(data)")
                completion(.success(data))
            case .failure(let error):
                Log("[D] 회원가입 실패 \(error)")
                completion(.failure(error))
            }
        }
    }
    
    static func signout(completion: @escaping (Result<(Bool), Error>) -> Void) {
        AF.request(AuthAPI.signOut, interceptor: TokenInterceptor.shared.getInterceptor()).response { response in
            print(response.data)
            print(response.response)
            print(response.result)
            print(response.error)
            print(response.request)
            print(response.debugDescription)
            print(response.description)
            print(response.value)
            if response.response?.statusCode == 200 {
                completion(.success(true))
            } else {
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            }
        }
    }
    
    static func postTestSign(request: TestUserRegistrationRequest, completion: @escaping (Result<SignResponse, Error>) -> Void) {
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
            print(response.data)
            print(response.response)
            print(response.result)
            print(response.error)
            print(response.request)
            print(response.debugDescription)
            print(response.description)
            print(response.value)
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
