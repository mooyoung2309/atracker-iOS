//
//  SummaryApplicationStatusView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit
import Then

class SummaryApplicationView: UIView {
    var pieChartView = PieChartView()
    var firstTitleLabel = UILabel().then {
        $0.text = "1차 면접"
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = Const.Color.black
    }
    var firstValueLabel = UILabel().then {
        $0.text = "89.0%"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = Const.Color.black
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    init() {
        super.init(frame: .zero)
        setView()
    }
}

extension SummaryApplicationView {
    func setView() {
        
    }
}
