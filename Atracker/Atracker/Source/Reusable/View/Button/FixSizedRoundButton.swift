//
//  RoundButton.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/24.
//

import UIKit

class FixSizedRoundButton: UIButton {
    var title: String!
    var selectedColor: UIColor!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(size: CGSize, round: CGFloat, title: String? = nil, image: UIImage? = nil, backgroundColor: UIColor, tintColor: UIColor, borderColor: UIColor, selectedColor: UIColor) {
        super.init(frame: .zero)
        self.title = title
        self.selectedColor = selectedColor
        setTitle(title, for: .normal)
        setTitleColor(.gray3, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        
        setImage(image, for: .normal)
        imageView?.tintColor = tintColor
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = round
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        
        snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
        }
    }
//
//    override var isSelected: Bool {
//        get {
//            return super.isHighlighted
//        }
//        set {
//            if newValue {
//                if title == "합격" {
//                    layer.borderColor = UIColor.neonGreen.cgColor
//                    setTitleColor(.neonGreen, for: .normal)
//                } else {
//                    layer.borderColor = UIColor.white.cgColor
//                    setTitleColor(.white, for: .normal)
//                }
//            } else {
//                layer.borderColor = UIColor.backgroundLightGray.cgColor
//                setTitleColor(.gray3, for: .normal)
//            }
//            super.isHighlighted = newValue
//        }
//    }
//
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                layer.borderColor = selectedColor.cgColor
                setTitleColor(selectedColor, for: .normal)
            } else {
                layer.borderColor = UIColor.clear.cgColor
                setTitleColor(.gray3, for: .normal)
            }
            super.isHighlighted = newValue
        }
    }
}