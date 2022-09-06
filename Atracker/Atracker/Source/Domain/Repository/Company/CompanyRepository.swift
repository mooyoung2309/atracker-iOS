//
//  CompanyRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/01.
//

import Alamofire
import RxSwift

protocol CompanyRepositable {
    func search(queryRequest: CompanySearchQuery, bodyRequest: CompanySearchCondition) -> Observable<CompanyResponse>
}

class CompanyRepository: Repository, CompanyRepositable {
    func search(queryRequest: CompanySearchQuery, bodyRequest: CompanySearchCondition) -> Observable<CompanyResponse> {
        return send(api: CompanyAPI.search(queryRequest, bodyRequest))
    }
    
    func add(request: CompanyCreateRequests) -> Observable<CompanyCreateResponse> {
        return send(api: CompanyAPI.companies(request))
    }
}

