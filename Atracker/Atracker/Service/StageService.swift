//
//  StageService.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/06.
//

import Foundation

protocol StageServiceProtocol {
    func get(completion: @escaping (Result<StageResponse, Error>) -> Void)
    func post(stageCreateRequest: StageCreateRequest, completion: @escaping (Result<StageCreateResponse, Error>) -> Void)
}

class StageService: StageServiceProtocol {
    let stageRepository = StageRepository()
    
    func get(completion: @escaping (Result<StageResponse, Error>) -> Void) {
        stageRepository.get { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func post(stageCreateRequest: StageCreateRequest, completion: @escaping (Result<StageCreateResponse, Error>) -> Void) {
        stageRepository.post(request: stageCreateRequest) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
