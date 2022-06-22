//
//  AuthRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation
import Alamofire

protocol AuthRepositoryProtocol {
    func postTestSign(request: TestUserRegistrationRequest, completion: @escaping (Result<SignResponse, Error>) -> Void )
}

class AuthRepository: AuthRepositoryProtocol {
    func postTestSign(request: TestUserRegistrationRequest, completion: @escaping (Result<SignResponse, Error>) -> Void ) {
        
        AF.request(AuthRouter.testSign(request)).responseDecodable { (response: AFDataResponse<SignResponse>) in
            print(request)
            print(response)
            switch response.result {
            case .success(let data):
                print(data)
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
