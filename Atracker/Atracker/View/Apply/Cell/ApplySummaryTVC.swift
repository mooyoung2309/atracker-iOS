//
//  ApplicationProgressTableViewCell.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit
import Then

class ApplySummaryTVC: UITableViewCell {
    static let identifier = "ProgressApplicationTableViewCell"
    var applicationProgress: Application!
    
    var companyLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    var positionLabel = UILabel().then {
        $0.textColor = .contentGray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
    }
    var progressBarView = HorizontalBarChartView()
    var barView = BarChatView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    func update(applicationProgress: Application) {
        self.applicationProgress = applicationProgress
        companyLabel.text = self.applicationProgress.company
        positionLabel.text = self.applicationProgress.position
    }
}

extension ApplySummaryTVC {
    func setView() {
//        layer.masksToBounds = true
//        layer.borderColor = Const.Color.darkGray.cgColor
//        layer.borderWidth = 1
        
        backgroundColor = .mainViewColor
        
        addSubview(companyLabel)
        addSubview(positionLabel)
        addSubview(barView)
        
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        barView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            positionLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: companyLabel.trailingAnchor, constant: 8),
            
            barView.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 11),
            barView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            barView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            barView.widthAnchor.constraint(equalToConstant: 100),
            barView.heightAnchor.constraint(equalToConstant: 5),
            barView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
