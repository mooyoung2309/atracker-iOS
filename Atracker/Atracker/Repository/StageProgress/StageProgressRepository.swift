//
//  StageProgressRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation
import Alamofire

class StageProgressRepository {
    func put(request: StageProgressUpdateRequest, completion: @escaping (Result<(), Error>) -> Void) {
        AF.request(StageProgressAPI.put(request), interceptor: TokenInterceptor.shared.getInterceptor()).response { response in
            print(response.data)
            print(response.response)
            print(response.result)
            print(response.error)
            print(response.request)
            print(response.debugDescription)
            print(response.description)
            print(response.value)
            switch response.result {
            case .success(_):
                Log("[D] 후기 업데이트 성공")
                completion(.success(()))
            case .failure(let error):
                Log("[D] 후기 업데이트 실패")
                completion(.failure(error))
            }
        }
    }
}
