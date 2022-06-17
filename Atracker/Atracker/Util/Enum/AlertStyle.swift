//
//  AlertStyle.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/17.
//

import UIKit

enum AlertStyle {
    case delete
    case next
    case back
    case save
    
    func title(i: Int = 0) -> NSMutableAttributedString {
        var title: String
        var attriTitle: NSMutableAttributedString
        
        switch self {
        case .delete:
            title       = "\(i)개의 후기를 정말 삭제하시겠습니까?"
            attriTitle  = NSMutableAttributedString(string: title)
            attriTitle.addAttribute(.foregroundColor,
                                    value: UIColor.neonGreen,
                                    range: (title as NSString).range(of: "\(i)개의 후기"))
            attriTitle.addAttribute(.font,
                                    value: UIFont.systemFont(ofSize: 16, weight: .bold),
                                    range: (title as NSString).range(of: "\(i)개의 후기"))
            return attriTitle
        case .next:
            title       = "이전 전형에 합격을 선택하셔야\n다음 전형으로 넘어갈 수 있습니다."
            attriTitle  = NSMutableAttributedString(string: title)
            return attriTitle
        case .back:
            title       = "작성을 취소하고 나가시겠습니까?"
            attriTitle  = NSMutableAttributedString(string: title)
            return attriTitle
        case .save:
            title       = "저장이 완료되었습니다!"
            attriTitle  = NSMutableAttributedString(string: title)
            attriTitle.addAttribute(.foregroundColor,
                                    value: UIColor.neonGreen,
                                    range: (title as NSString).range(of: title))
            return attriTitle
        }
    }
    
    var subTitle: String? {
        switch self {
        case .delete:
            return "이 작업은 취소하실 수 없습니다."
        case .next:
            return nil
        case .back:
            return "작성하던 내용이 저장되지 않습니다."
        case .save:
            return "지원 현황에서 확인해 보세요."
        }
    }
    
    var buttonTitles: [String] {
        switch self {
        case .delete:
            return ["취소", "삭제"]
        case .next:
            return ["확인"]
        case .back:
            return ["취소", "나가기"]
        case .save:
            return ["계속 수정", "나가기"]
        }
    }
    
    var iamgeName: String {
        switch self {
        case .delete:
            return ImageName.warning
        case .next:
            return ImageName.warning
        case .back:
            return ImageName.warning
        case .save:
            return ImageName.notification
        }
    }
    
}
