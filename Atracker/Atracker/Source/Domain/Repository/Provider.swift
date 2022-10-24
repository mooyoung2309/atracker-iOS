//
//  Provider.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/31.
//

import Foundation

protocol APIRepositable {
    var company: CompanyRepositableISOLDCODE { get }
}

class APIRepository: APIRepositable {
    let company: CompanyRepositableISOLDCODE
    
    init(company: CompanyRepositableISOLDCODE) {
        self.company = company
    }
}

protocol Providable {
    var api: APIRepository { get }
}

final class Provider: Providable {
    static let shared = Provider()
    
    let api: APIRepository = APIRepository(company: CompanyRepositoryISOLDCODE())
    
    private init() { }
}
