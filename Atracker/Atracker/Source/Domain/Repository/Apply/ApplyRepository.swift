//
//  ApplyRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation
import Alamofire

protocol ApplyRepositoryProtocol {
    func get(request: ApplyRequest, completion: @escaping (Result<ApplyResponse, Error>) -> Void)
    func post(request: ApplyCreateRequest, completion: @escaping (Result<(), Error>) -> Void)
    func put(request: ApplyUpdateRequest, completion: @escaping (Result<(Bool), Error>) -> Void)
    func delete(request: ApplyDeleteRequest, completion: @escaping (Result<(Bool), Error>) -> Void)
}

class ApplyRepository: ApplyRepositoryProtocol {
    static let shared = ApplyRepository()
    
    func get(request: ApplyRequest, completion: @escaping (Result<ApplyResponse, Error>) -> Void) {
        AF.request(ApplyAPI.get(request), interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<ApplyResponse>) in
            switch response.result {
            case .success(let data):
                var applies: [Apply] = []
                for apply in data.applies {
                    var newApply = apply
                    newApply.stageProgress = newApply.stageProgress.sorted(by: { $0.order < $1.order })
                    applies.append(newApply)
                }
                print("[D] GET APPLY ⭕️ SUCCESS")
                completion(.success(ApplyResponse(applies: applies)))
            case .failure(let error):
                print("[D] GET APPLY ❌ FAILURE")
                completion(.failure(error))
            }
        }
    }
    
    func post(request: ApplyCreateRequest, completion: @escaping (Result<(), Error>) -> Void) {
        AF.request(ApplyAPI.post(request), interceptor: TokenInterceptor.shared.getInterceptor()).response { response in
            switch response.result {
            case .success:
                print("[D] POST APPLY ⭕️ SUCCESS")
                completion(.success(()))
            case .failure(let error):
                print("[D] POST APPLY ❌ FAILURE")
                completion(.failure(error))
            }
        }
    }
    
    func put(request: ApplyUpdateRequest, completion: @escaping (Result<(Bool), Error>) -> Void) {
        AF.request(ApplyAPI.put(request), interceptor: TokenInterceptor.shared.getInterceptor()).response { response in
            if response.response?.statusCode == 200 {
                print("[D] PUT APPLY ⭕️ SUCCESS")
                completion(.success(true))
            } else {
                print("[D] PUT APPLY ❌ FAILURE")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            }
        }
    }
    
    func delete(request: ApplyDeleteRequest, completion: @escaping (Result<(Bool), Error>) -> Void) {
        AF.request(ApplyAPI.delete(request), interceptor: TokenInterceptor.shared.getInterceptor()).response { response in
            if response.response?.statusCode == 200 {
                print("[D] DELETE APPLY ⭕️ SUCCESS")
                completion(.success(true))
            } else {
                print("[D] DELETE APPLY ❌ FAILURE")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            }
        }
    }
}
