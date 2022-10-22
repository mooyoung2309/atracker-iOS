//
//  AtrackerButton.swift
//  Atracker
//
//  Created by 송영모 on 2022/10/22.
//

import UIKit

enum AtrackerButtonType {
    case next
    
    var title: String {
        switch self {
        case .next:
            return "다음"
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .next:
            return .neonGreen
        }
    }
}

class AtrackerButton: UIButton {
    
    let type: AtrackerButtonType
    
    init(type: AtrackerButtonType) {
        self.type = type
        
        super.init(frame: .zero)
        
        self.setTitle(type.title, for: .normal)
        self.setTitleColor(.neonGreen, for: .normal)
        self.setTitleColor(.gray3, for: .highlighted)
        self.backgroundColor = .backgroundGray
        self.addShadow(.top)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
