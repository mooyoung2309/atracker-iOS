//
//  CalendarCollectionViewCell.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit
import SnapKit
import Then

class CalendarCVC: BaseCVC {
    static let id = "CalendarCVC"
    
    let circleStackView = UIStackView()
    let circleView1     = CircleView(color: .blue5)
    let circleView2     = CircleView(color: .neonGreen)
    let dateLabel       = UILabel()
    
    let dateFormatter   = DateFormatter()
    
    func update(date: Date) {
        dateLabel.text = "\(date.getDay())"
        dateLabel.textColor = .white
    }
    
    func updateTextColor(color: UIColor) {
        dateLabel.textColor = color
    }
    
    override func prepareForReuse() {
        circleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        dateLabel.textColor = .white
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .clear
        circleStackView.addArrangedSubviews([circleView1, circleView2])
        
        circleStackView.axis = .horizontal
        circleStackView.spacing = 2
        circleStackView.distribution = .fillProportionally
        
        dateLabel.font = .systemFont(ofSize: 15, weight: .regular)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.layer.cornerRadius = 10
        dateLabel.layer.masksToBounds = true
        
        circleStackView.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(circleStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
        }
        
        circleStackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
    func showCircle(_ bool: Bool) {
        if bool {
            circleStackView.isHidden = false
        } else {
            circleStackView.isHidden = true
        }
    }
}
