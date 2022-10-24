//
//  StageProgressService.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/15.
//

import Foundation

protocol StageProgressServiceProtocolISOLDCODE {
    func put(request: StageProgressUpdateRequest, completion: @escaping (Result<(), Error>) -> Void)
}

class StageProgressServiceISOLDCODe: StageProgressServiceProtocolISOLDCODE {
    let stageProgressRepository = StageProgressRepositoryISOLDCODE()
    
    func put(request: StageProgressUpdateRequest, completion: @escaping (Result<(), Error>) -> Void) {
        stageProgressRepository.put(request: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
    
