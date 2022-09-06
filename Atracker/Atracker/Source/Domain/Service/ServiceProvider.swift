//
//  ServiceProvider.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/29.
//

import Foundation

protocol ServiceProvidable {
    var applyService: ApplyServicable { get }
    var companyService: CompanyServicable { get }
    var stageService: StageServicable { get }
}

final class ServiceProvider: ServiceProvidable {
    static let shared = ServiceProvider()
    
    let applyService: ApplyServicable = ApplyService()
    let companyService: CompanyServicable = CompanyService()
    let stageService: StageServicable = StageService()
    
    private init() { }
}
