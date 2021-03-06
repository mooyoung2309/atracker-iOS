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
}

class ApplyRepository: ApplyRepositoryProtocol {
    static let shared = ApplyRepository()
    
    func get(request: ApplyRequest, completion: @escaping (Result<ApplyResponse, Error>) -> Void) {
        AF.request(ApplyAPI.get(request), interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<ApplyResponse>) in
//            print(response.data)
//            print(response.response)
//            print(response.result)
//            print(response.error)
//            print(response.request)
//            print(response.debugDescription)
//            print(response.description)
//            print(response.value)
            switch response.result {
            case .success(let data):
                Log("[D] 지원 현황 가져오기 성공")
                completion(.success(data))
            case .failure(let error):
                Log("[D] 지원 현황 가져오기 실패")
                completion(.failure(error))
            }
        }
    }
    
    func post(request: ApplyCreateRequest, completion: @escaping (Result<(), Error>) -> Void) {
        AF.request(ApplyAPI.post(request), interceptor: TokenInterceptor.shared.getInterceptor()).response { response in
//            print(response.data)
//            print(response.response)
//            print(response.result)
//            print(response.error)
//            print(response.request)
//            print(response.debugDescription)
//            print(response.description)
//            print(response.value)
            switch response.result {
            case .success(_):
                Log("[D] 지원 현황 생성 성공")
                completion(.success(()))
            case .failure(let error):
                Log("[D] 지원 현황 생성 실패")
                completion(.failure(error))
            }
        }
    }
}
