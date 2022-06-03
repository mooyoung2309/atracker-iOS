//
//  AutoSizedRoundButton.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/29.
//

import UIKit

class AutoSizedRoundButton: UIButton {
    var title: String!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(_ title: String, selectedColor: UIColor) {
        super.init(frame: .zero)
        self.title = title
        setTitle(title, for: .normal)
        backgroundColor = .backgroundLightGray
        setTitleColor(.gray3, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        layer.cornerRadius = 13
        layer.borderWidth = 1
        layer.borderColor = UIColor.backgroundLightGray.cgColor
    }
}
