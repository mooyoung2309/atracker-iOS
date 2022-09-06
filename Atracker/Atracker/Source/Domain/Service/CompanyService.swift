//
//  CompanyService.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/01.
//

import Alamofire
import RxSwift

protocol CompanyServicable {
    func search(title: String, page: Int) -> Observable<CompanyResponse>
    func add(name: String) -> Observable<CompanyCreateResponse>
}

class CompanyService: CompanyServicable {
    let repository: CompanyRepository = .init()
    
    func search(title: String, page: Int) -> Observable<CompanyResponse> {
        return repository.search(queryRequest: .init(page: page, size: 10), bodyRequest: .init(title: title, userDefined: true))    }
    
    func add(name: String) -> Observable<CompanyCreateResponse> {
        return repository.add(request: [.init(name: name)])
    }
}
