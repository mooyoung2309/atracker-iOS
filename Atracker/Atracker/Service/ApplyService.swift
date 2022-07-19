//
//  ApplyService.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation

protocol ApplyServiceProtocol {
    func get(request: ApplyRequest, completion: @escaping (Result<ApplyResponse, Error>) -> Void)
    func post(request: ApplyCreateRequest, completion: @escaping (Result<Void, Error>) -> Void)
    func put(request: ApplyUpdateRequest, completion: @escaping (Result<(Bool), Error>) -> Void)
}

class ApplyService: ApplyServiceProtocol {
    func get(request: ApplyRequest, completion: @escaping (Result<ApplyResponse, Error>) -> Void) {
        ApplyRepository.shared.get(request: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func post(request: ApplyCreateRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        ApplyRepository.shared.post(request: request) { result in
            switch result {
            case .success(let data):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func put(request: ApplyUpdateRequest, completion: @escaping (Result<(Bool), Error>) -> Void) {
        ApplyRepository.shared.put(request: request) { result in
            switch result {
            case .success(let bool):
                completion(.success(bool))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
