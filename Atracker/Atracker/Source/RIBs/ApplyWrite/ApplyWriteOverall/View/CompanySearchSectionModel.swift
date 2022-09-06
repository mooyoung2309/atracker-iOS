//
//  CompanySearchSectionModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/06.
//

import RxDataSources

typealias CompanySearchSectionModel = SectionModel<CompanySearchSection, CompanySearchItem>

enum CompanySearchSection {
    case search([CompanySearchItem])
}

enum CompanySearchItem {
    case result(CompanySearchTableViewCellReactor)
}

extension CompanySearchSection: SectionModelType {
    typealias Item = CompanySearchItem
    
    var items: [Item] {
        switch self {
        case let .search(items):
            return items
        }
    }
    
    init(original: CompanySearchSection, items: [CompanySearchItem]) {
        switch original {
        case let .search(items):
            self = .search(items)
        }
    }
}
