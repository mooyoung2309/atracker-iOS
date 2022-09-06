//
//  UserService.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/18.
//

import Foundation

protocol UserServiceProtocolISOLDCODE {
    func myPage(completion: @escaping (Result<MyPageResponse, Error>) -> Void)
}

class UserServiceISOLDCODE: UserServiceProtocolISOLDCODE {
    func myPage(completion: @escaping (Result<MyPageResponse, Error>) -> Void) {
        UserRepositoryISOLDCODE.shared.myPage { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

