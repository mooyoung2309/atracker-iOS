//
//  CalendarSectionModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/11/27.
//

import RxDataSources

typealias CalendarSectionModel = SectionModel<CalendarSection, CalendarItem>

enum CalendarSection {
    case calendar([CalendarItem])
}

enum CalendarItem {
    case calendar(CalendarCollectionViewCellReactor)
}

extension CalendarSection: SectionModelType {
    typealias Item = CalendarItem
    
    var items: [Item] {
        switch self {
        case let .calendar(items):
            return items
        }
    }
    
    init(original: CalendarSection, items: [CalendarItem]) {
        switch original {
        case let .calendar(items):
            self = .calendar(items)
        }
    }
}

