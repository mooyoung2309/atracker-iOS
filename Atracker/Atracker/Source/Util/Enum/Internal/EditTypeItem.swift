//
//  EditTypeItem.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/18.
//

import Foundation

enum EditTypeItem {
    case apply
    case stage
    case delete
    
    static var list: [EditTypeItem] {
        return [EditTypeItem.apply, EditTypeItem.stage, EditTypeItem.delete]
    }
    
    var title: String {
        switch self {
        case .apply:
            return "지원 후기 수정하기"
        case .stage:
            return "전형 편집하기"
        case .delete:
            return "지원 후기 삭제하기"
        }
    }
    
    var imageName: String {
        switch self {
        case .apply:
            return ImageName.pen
        case .stage:
            return ImageName.list
        case .delete:
            return ImageName.trash
        }
    }
}
