//
//  WriteApplyTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class WriteApplyScheduleTVC: BaseTVC {
    static let id = "WriteApplyScheduleTVC"
    var disposeBag = DisposeBag()
    
    let circle          = UIView()
    let titleLabel      = UILabel()
    let datePicker      = UIDatePicker()
    let dateLabel       = UILabel()
    let divisionLabel   = UILabel()
    let timeLabel       = UILabel()
    
    var dateChanged: ((Date) -> Void)?
    
    func showDatePicker() {
        datePicker.isHidden = false
        datePicker.snp.updateConstraints {
            $0.height.equalTo(132)
        }
    }
    
    func hideDatePicker() {
        datePicker.isHidden = true
        datePicker.snp.updateConstraints {
            $0.height.equalTo(0)
        }
    }
    
    func update(date: Date?) {
        guard let date = date else {
            return
        }
        
        dateLabel.text = date.getKRString()
        datePicker.date = date
    }
    
    func dateChanged(completion: @escaping (Date) -> Void) {
        self.dateChanged = completion
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = "+"
        datePicker.date = Date()
        
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
        
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.minuteInterval = 5
        datePicker.datePickerMode = .dateAndTime
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        
        circle.backgroundColor  = .neonGreen
        titleLabel.text         = "서류"
//        dateLabel.text          = "2022  03  12     오후  12 : 00"
        dateLabel.text = "+"
        dateLabel.textAlignment = .center
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
            $0.leading.equalToSuperview().inset(16)
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
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(111)
            $0.trailing.equalToSuperview().inset(40)
            $0.centerY.equalTo(titleLabel)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        datePicker.rx.date
            .bind { [weak self] date in
                self?.dateChanged?(date)
            }
            .disposed(by: disposeBag)
    }
}
