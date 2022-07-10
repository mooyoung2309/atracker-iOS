//
//  ApplyService.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation

protocol ApplyServiceProtocol {
    func get(request: ApplyRequest, completion: @escaping (Result<ApplyResponse, Error>) -> Void)
    func post(request: ApplyCreateRequest, completion: @escaping (Int) -> Void)
}

class ApplyService: ApplyServiceProtocol {
    let applyRepository = ApplyRepository()
    
    func get(request: ApplyRequest, completion: @escaping (Result<ApplyResponse, Error>) -> Void) {
        applyRepository.get(request: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func post(request: ApplyCreateRequest, completion: @escaping (Int) -> Void) {
        applyRepository.post(request: request) { result in
            completion(result)
        }
    }
}
