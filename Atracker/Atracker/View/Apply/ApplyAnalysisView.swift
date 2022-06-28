//
//  ApplyAnalysisView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import UIKit
import SnapKit

class ApplyAnalysisView: BaseView {
    
    let backgroundView  = UIView()
    let sumView         = UIView()
    let sumLabel        = UILabel()
    let sumPercentLabel = UILabel()
    let chartView       = UIView()
    let boxStackView    = UIStackView()
    let firstBox        = SummaryBoxView(color: .blue6,title: "서류전형", percent: "75%")
    let secondBox       = SummaryBoxView(color: .blue4 ,title: "면접전형", percent: "50%")
    let thirdBox        = SummaryBoxView(color:.blue2 ,title: "최종전형", percent: "25%")
    
    var pieChartView = PieChartView(data: [])
    var sumPercentText = "20%"
    
    func updatePieChart(data: [CGFloat]) {
        pieChartView.removeFromSuperview()
        
        pieChartView = PieChartView(data: data)
        
        chartView.addSubview(pieChartView)
        
        pieChartView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        sumLabel.text = "합격률"
        sumLabel.font = .systemFont(ofSize: 12, weight: .regular)
        sumLabel.textColor = .gray1
        sumLabel.textAlignment = .center
        
        sumPercentLabel.font = .systemFont(ofSize: 18, weight: .bold)
        let percentAttributeString = NSMutableAttributedString(string: sumPercentText)
        percentAttributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: (sumPercentText as NSString).range(of: "%"))
        sumPercentLabel.attributedText = percentAttributeString
        sumPercentLabel.textColor = .white
        sumPercentLabel.textAlignment = .center
        
        backgroundView.backgroundColor = .backgroundLightGray
        backgroundView.layer.cornerRadius = 10
        
        boxStackView.axis = .horizontal
        boxStackView.distribution = .fillEqually
        boxStackView.spacing = 5
        boxStackView.addArrangedSubviews([firstBox, secondBox, thirdBox])
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(chartView)
        addSubview(sumView)
        addSubview(boxStackView)
        
        sumView.addSubview(sumLabel)
        sumView.addSubview(sumPercentLabel)
        chartView.addSubview(pieChartView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        chartView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
            $0.width.height.equalTo(64)
        }
        
        sumView.snp.makeConstraints {
            $0.center.equalTo(chartView)
        }
        
        sumLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        sumPercentLabel.snp.makeConstraints {
            $0.top.equalTo(sumLabel.snp.bottom).inset(-1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        boxStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(100)
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
    }
}
