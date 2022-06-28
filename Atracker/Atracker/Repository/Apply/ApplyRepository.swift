//
//  ApplyRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation
import Alamofire

protocol ApplyRepositoryProtocol {
    func getApply(request: GetApplyQuery, completion: @escaping (Result<ApplyResponse, Error>) -> Void)
}

class ApplyRepository: ApplyRepositoryProtocol {
    static let shared = ApplyRepository()
    
    func getApply(request: GetApplyQuery, completion: @escaping (Result<ApplyResponse, Error>) -> Void) {
        AF.request(ApplyAPI.getApply(request)).responseDecodable { (response: AFDataResponse<ApplyResponse>) in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    func postApply(request: GetApplyQuery, completion: @escaping (Result<ApplyResponse, Error>) -> Void)
    
    func postTestSign(request: TestUserRegistrationRequest, completion: @escaping (Result<SignResponse, Error>) -> Void) {
        
        AF.request(AuthRouter.testSign(request)).responseDecodable { (response: AFDataResponse<SignResponse>) in
            
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
        
        AF.request(AuthRouter.tokenRefresh(request)).responseDecodable { (response: AFDataResponse<TokenRefreshResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
