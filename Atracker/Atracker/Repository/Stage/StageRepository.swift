//
//  StageRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/06.
//

import Foundation
import Alamofire

class StageRepository {
    func get(completion: @escaping(Result<StageResponse, Error>) -> Void) {
        AF.request(StageAPI.get, interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<[Stage]>) in
            switch response.result {
            case .success(let data):
                Log("[D] 성공")
                completion(.success(data))
            case .failure(let error):
                Log("[D] 실패")
                completion(.failure(error))
            }
        }
    }
    
    func post(request: StageCreateRequest, completion: @escaping(Result<StageCreateResponse, Error>) -> Void) {
        AF.request(StageAPI.post(request), interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<StageCreateResponse>) in
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
                Log("[D] 성공")
                completion(.success(data))
            case .failure(let error):
                Log("[D] 실패 \(error)")
                completion(.failure(error))
            }
        }
    }
}
