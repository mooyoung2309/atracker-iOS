//
//  ApplyWriteDateView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import UIKit
import SnapKit

class ApplyWriteDateView: BaseView {
    
    let dateLabel       = UILabel()
    let weekStackView   = UIStackView()
    
    override func setupProperty() {
        super.setupProperty()
        
        dateLabel.text = "2022.06"
        
        weekStackView.distribution = .fillEqually
        
        for week in ["월", "화", "수", "목", "금", "토", "일"] {
            let label           = UILabel()
            label.text          = week
            label.font          = .systemFont(ofSize: 14, weight: .regular)
            label.textColor     = .white
            label.textAlignment = .center
            weekStackView.addArrangedSubview(label)
            
        }
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(dateLabel)
        addSubview(weekStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.centerX.equalToSuperview()
        }
        
        weekStackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(11)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
