//
//  CircleView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/27.
//

import UIKit
import SnapKit
import Then

class CircleView: UIView {

    var circleView = UIView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(color: UIColor) {
        super.init(frame: .zero)
        setupProperty(color: color)
        setupHierarchy()
        setupLayout()
    }
}

extension CircleView {
    func setupProperty(color: UIColor) {
        circleView.backgroundColor = color
    }
    
    func setupHierarchy() {
        addSubview(circleView)
    }
    
    func setupLayout() {
        circleView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.height.equalTo(6)
        }
    }
}

