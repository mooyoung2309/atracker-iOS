//
//  SearchSectionModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/29.
//

import RxDataSources

typealias SearchSectionModel = SectionModel<SearchSection, SearchItem>

enum SearchSection {
    case search([SearchItem])
}

enum SearchItem {
    case result(ResultTableViewCellReator)
}

extension SearchSection: SectionModelType {
    typealias Item = SearchItem
    
    var items: [Item] {
        switch self {
        case let .search(items):
            return items
        }
    }
    
    init(original: SearchSection, items: [SearchItem]) {
        switch original {
        case let .search(items):
            self = .search(items)
        }
    }
}
