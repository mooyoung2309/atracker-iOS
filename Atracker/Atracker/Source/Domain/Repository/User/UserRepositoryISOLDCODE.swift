//
//  UserRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/18.
//

import Foundation
import Alamofire

class UserRepositoryISOLDCODE {
    static let shared = UserRepositoryISOLDCODE()
    
    func myPage(completion: @escaping(Result<MyPageResponse, Error>) -> Void) {
        AF.request(UserAPI.myPage, interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<MyPageResponse>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
