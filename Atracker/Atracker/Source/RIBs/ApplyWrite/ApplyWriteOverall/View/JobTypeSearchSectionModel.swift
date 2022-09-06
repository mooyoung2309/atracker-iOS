//
//  JobTypeSearchSectionModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/06.
//

import RxDataSources

typealias JobTypeSearchSectionModel = SectionModel<JobTypeSearchSection, JobTypeSearchItem>

enum JobTypeSearchSection {
    case search([JobTypeSearchItem])
}

enum JobTypeSearchItem {
    case result(JobTypeSearchTableViewCellReactor)
}

extension JobTypeSearchSection: SectionModelType {
    typealias Item = JobTypeSearchItem
    
    var items: [Item] {
        switch self {
        case let .search(items):
            return items
        }
    }
    
    init(original: JobTypeSearchSection, items: [JobTypeSearchItem]) {
        switch original {
        case let .search(items):
            self = .search(items)
        }
    }
}
