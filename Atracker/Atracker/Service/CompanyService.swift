//
//  CompanyService.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Alamofire

protocol CompanyServiceProtocol {
    func search(title: String, page: Int, completion: @escaping (Result<CompanyResponse, Error>) -> Void)
    func add(name: String, completion: @escaping (Result<CompanyCreateResponse, Error>) -> Void)
}

class CompanyService: CompanyServiceProtocol {
    let companyRepository = CompanyRepository()
    
    func search(title: String, page: Int, completion: @escaping (Result<CompanyResponse, Error>) -> Void) {
        
        companyRepository.search(queryRequest: .init(page: page, size: 10), bodyRequest: .init(title: title, userDefined: true)) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func add(name: String, completion: @escaping (Result<CompanyCreateResponse, Error>) -> Void) {
        
        companyRepository.add(request: [CompanyCreateRequest(name: name)]) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

