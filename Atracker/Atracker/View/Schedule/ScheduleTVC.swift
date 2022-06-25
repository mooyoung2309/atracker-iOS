//
//  CalendarTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import Foundation
import UIKit
import SnapKit

class ScheduleTVC: BaseTVC {
    static let id = "ScheduleTVC"
    
    let circle          = UIView()
    let titleLabel      = UILabel()
    let datePicker      = UIDatePicker()
    let dateLabel       = UILabel()
    let divisionLabel   = UILabel()
    let timeLabel       = UILabel()
    
    func showDatePicker() {
        datePicker.isHidden = false
        datePicker.snp.updateConstraints {
            $0.height.equalTo(190)
        }
    }
    
    func hideDatePicker() {
        datePicker.isHidden = true
        datePicker.snp.updateConstraints {
            $0.height.equalTo(0)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideDatePicker()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .clear
        
        circle.layer.cornerRadius = 3
        
        titleLabel.font         = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor    = .white
        
        dateLabel.font          = .systemFont(ofSize: 16, weight: .regular)
        dateLabel.textColor     = .gray3
        
        divisionLabel.font      = .systemFont(ofSize: 14, weight: .regular)
        divisionLabel.textColor = .gray5
        
        timeLabel.font          = .systemFont(ofSize: 16, weight: .regular)
        timeLabel.textColor     = .gray3
        
        datePicker.locale = Locale(identifier: "ko-KR")
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        
        circle.backgroundColor  = .neonGreen
        titleLabel.text         = "서류"
        dateLabel.text          = "2022  03  12"
        divisionLabel.text      = "오후"
        timeLabel.text          = "12 : 00"
        datePicker.isHidden     = true
        datePicker.backgroundColor = .backgroundLightGray
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(circle)
        contentView.addSubview(titleLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(dateLabel)
        contentView.addSubview(divisionLabel)
        contentView.addSubview(timeLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()

        circle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.centerY.equalTo(titleLabel)
            $0.width.height.equalTo(6)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(circle.snp.trailing).inset(-7)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
//            $0.bottom.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.centerY.equalTo(titleLabel)
        }
        
        divisionLabel.snp.makeConstraints {
            $0.trailing.equalTo(timeLabel.snp.leading).inset(-14)
            $0.centerY.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(divisionLabel.snp.leading).inset(-26)
            $0.centerY.equalTo(titleLabel)
        }
    }
}
