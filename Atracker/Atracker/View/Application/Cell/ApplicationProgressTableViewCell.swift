//
//  ApplicationProgressTableViewCell.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit
import Then

class ApplicationProgressTableViewCell: UITableViewCell {
    static let identifier = "ProgressApplicationTableViewCell"
    var applicationProgress: ApplicationProgress!
    
    var companyLabel = UILabel().then {
        $0.textColor = Const.Color.black
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    var positionLabel = UILabel().then {
        $0.textColor = Const.Color.darkGray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
    }
    var progressBarView = UIView().then {
        $0.backgroundColor = Const.Color.orange
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    func update(applicationProgress: ApplicationProgress) {
        self.applicationProgress = applicationProgress
        companyLabel.text = self.applicationProgress.company
        positionLabel.text = self.applicationProgress.position
    }
}

extension ApplicationProgressTableViewCell {
    func setView() {
//        layer.masksToBounds = true
//        layer.borderColor = Const.Color.darkGray.cgColor
//        layer.borderWidth = 1
        
        addSubview(companyLabel)
        addSubview(positionLabel)
        addSubview(progressBarView)
        
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            positionLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: companyLabel.trailingAnchor, constant: 8),
            
            progressBarView.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            progressBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressBarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
