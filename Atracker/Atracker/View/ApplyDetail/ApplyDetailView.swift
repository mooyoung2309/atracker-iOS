//
//  ApplyDetailView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/11.
//

import UIKit
import SnapKit

class ApplyDetailView: BaseView {
    
    let barChartView    = BarChatView()
    let dateLabel       = UILabel().then {
        $0.text = "2022.06.12"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .gray2
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        addSubview(barChartView)
        addSubview(dateLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        barChartView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(barChartView.snp.bottom).inset(-13)
            $0.leading.equalToSuperview().inset(24)
        }
    }
}
