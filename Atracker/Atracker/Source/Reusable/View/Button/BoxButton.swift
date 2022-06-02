//
//  BoxButton.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/24.
//

import UIKit

class BoxButton: UIButton {
    var title: String!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(_ title: String, selectedColor: UIColor) {
        super.init(frame: .zero)
        self.title = title
        setTitle(title, for: .normal)
        backgroundColor = .backgroundLightGray
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        layer.cornerRadius = 5
        
        snp.makeConstraints {
            $0.height.equalTo(36)
        }
    }
}
