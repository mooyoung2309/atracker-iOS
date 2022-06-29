//
//  ProgressBarView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import UIKit
import SnapKit

class ProgressBarView: BaseView {
    
    let stackView       = UIStackView()
    let barChartView    = BarChatView(.horizontal, cornerRadius: 5)
    
    var total: Int = 1
    var part: Int = 0
    
    func update(total: Int, part: Int) {
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        
        self.total = total
        self.part = part
        
        for i in 0...total {
            let divider = UIView()
            
            divider.backgroundColor = .backgroundGray
            
            if i == 0 || i == total {
                divider.backgroundColor = .clear
            }
            
            divider.snp.makeConstraints {
                $0.width.equalTo(1)
            }
            
            stackView.addArrangedSubview(divider)
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        barChartView.layer.cornerRadius = 20
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.layer.zPosition = 1
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(barChartView)
        barChartView.addSubview(stackView)
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        barChartView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
