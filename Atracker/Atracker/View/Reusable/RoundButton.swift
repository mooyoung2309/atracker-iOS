//
//  RoundButton.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/24.
//

import UIKit

class RoundButton: UIButton {
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
        
        snp.makeConstraints {
            $0.width.equalTo(65)
            $0.height.equalTo(26)
        }
    }
    
    override var isSelected: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                if title == "합격" {
                    layer.borderColor = UIColor.neonGreen.cgColor
                    setTitleColor(.neonGreen, for: .normal)
                } else {
                    layer.borderColor = UIColor.white.cgColor
                    setTitleColor(.white, for: .normal)
                }
            } else {
                layer.borderColor = UIColor.backgroundLightGray.cgColor
                setTitleColor(.gray3, for: .normal)
            }
            super.isHighlighted = newValue
        }
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                if title == "합격" {
                    layer.borderColor = UIColor.neonGreen.cgColor
                    setTitleColor(.neonGreen, for: .normal)
                } else {
                    layer.borderColor = UIColor.white.cgColor
                    setTitleColor(.white, for: .normal)
                }
            } else {
                layer.borderColor = UIColor.backgroundLightGray.cgColor
                setTitleColor(.gray3, for: .normal)
            }
            super.isHighlighted = newValue
        }
    }
}
