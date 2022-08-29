//
//  ServiceProvider.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/29.
//

import Foundation

protocol ServiceProviderProtocol: AnyObject {
    var applyService: ApplyServiceProtocol { get }
    var companyService: CompanyServiceProtocol { get }
}

final class ServiceProvider: ServiceProviderProtocol {
    static let shared = ServiceProvider()
    
    let applyService: ApplyServiceProtocol = ApplyService()
    let companyService: CompanyServiceProtocol = CompanyService()
    let stageService: StageServiceProtocolISOLDCODE = StageServiceISOLDCODE()
    
    private init() { }
}
