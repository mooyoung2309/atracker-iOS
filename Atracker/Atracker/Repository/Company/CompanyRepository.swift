//
//  CompanyRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Alamofire
import Foundation

class CompanyRepository {
    func search(queryRequest: CompanySearchQuery, bodyRequest: CompanySearchCondition, completion: @escaping (Result<CompanyResponse, Error>) -> Void) {
        AF.request(CompanyRouter.search(queryRequest, bodyRequest), interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<CompanyResponse>) in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}