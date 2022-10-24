//
//  StageSectionModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/31.
//

import RxDataSources

typealias StageSectionModel = SectionModel<StageSection, StageItem>

enum StageSection {
    case stage([StageItem])
}

enum StageItem {
    case stage(StageCollectionViewCellReactor)
}

extension StageSection: SectionModelType {
    typealias Item = StageItem
    
    var items: [Item] {
        switch self {
        case let .stage(items):
            return items
        }
    }
    
    init(original: StageSection, items: [StageItem]) {
        switch original {
        case let .stage(items):
            self = .stage(items)
        }
    }
}
