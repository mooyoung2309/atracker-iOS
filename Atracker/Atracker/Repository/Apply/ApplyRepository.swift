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
    func post(request: ApplyCreateRequest, completion: @escaping (Int) -> Void)
}

class ApplyRepository: ApplyRepositoryProtocol {
    static let shared = ApplyRepository()
    
    func get(request: ApplyRequest, completion: @escaping (Result<ApplyResponse, Error>) -> Void) {
        AF.request(ApplyAPI.get(request)).responseDecodable { (response: AFDataResponse<ApplyResponse>) in
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
    
    func post(request: ApplyCreateRequest, completion: @escaping (Int) -> Void) {
        AF.request(ApplyAPI.post(request)).responseDecodable { (response: AFDataResponse<Int>) in
            guard let statusCode = response.response?.statusCode else { return }
            
            switch statusCode {
            case 200:
                Log("[D] 지원 현황 생성 성공")
                completion(statusCode)
            default:
                Log("[D] 지원 현황 생성 실패")
                completion(statusCode)
            }
            
        }
    }
}
