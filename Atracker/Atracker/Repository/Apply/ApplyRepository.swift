//
//  ApplyRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation
import Alamofire

protocol ApplyRepositoryProtocol {
    func getApply(request: ApplyRequest, completion: @escaping (Result<Apply, Error>) -> Void)
}

class ApplyRepository: ApplyRepositoryProtocol {
    static let shared = ApplyRepository()
    
    func getApply(request: ApplyRequest, completion: @escaping (Result<Apply, Error>) -> Void) {
        AF.request(ApplyAPI.getApply(request)).responseDecodable { (response: AFDataResponse<Apply>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
