//
//  StageSearchSectionModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/07.
//

import RxDataSources

typealias StageSearchSectionModel = SectionModel<StageSearchSection, StageSearchItem>

enum StageSearchSection {
    case search([StageSearchItem])
}

enum StageSearchItem {
    case result(StageSearchCollectionViewCellReactor)
}

extension StageSearchSection: SectionModelType {
    typealias Item = StageSearchItem
    
    var items: [Item] {
        switch self {
        case let .search(items):
            return items
        }
    }
    
    init(original: StageSearchSection, items: [StageSearchItem]) {
        switch original {
        case let .search(items):
            self = .search(items)
        }
    }
}

