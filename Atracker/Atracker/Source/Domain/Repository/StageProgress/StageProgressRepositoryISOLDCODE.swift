//
//  StageProgressRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation
import Alamofire

class StageProgressRepositoryISOLDCODE {
    func put(request: StageProgressUpdateRequest, completion: @escaping (Result<(), Error>) -> Void) {
        AF.request(StageProgressAPI.put(request), interceptor: TokenInterceptor.shared.getInterceptor()).response { response in
            switch response.result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
