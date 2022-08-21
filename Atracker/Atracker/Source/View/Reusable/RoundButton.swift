//
//  RoundButton.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/14.
//

import UIKit

class RoundButton: UIButton {
    
    var color: UIColor?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setColor(color: .white)
    }
    
    func setColor(color: UIColor) {
        self.color = color
        
        setTitleColor(.gray3, for: .normal)
        setTitleColor(color, for: .selected)

        titleLabel?.font     = .systemFont(ofSize: 14, weight: .regular)
        layer.borderColor    = UIColor.clear.cgColor
        layer.cornerRadius   = 13
        layer.borderWidth    = 1
        
        backgroundColor = .backgroundLightGray
    }
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = color?.cgColor
            } else {
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}
