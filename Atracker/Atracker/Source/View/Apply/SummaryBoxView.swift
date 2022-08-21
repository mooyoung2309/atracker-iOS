//
//  SummaryBoxView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/23.
//

import UIKit
import Then
class SummaryBoxView: BaseView {
    let circleView = UIView().then {
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 4.5
    }
    let titleLabel = UILabel().then {
        $0.text = "서류"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gray1
    }
    let percentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .bold)
        $0.textColor = .white
    }
    
    func update(color: UIColor, title: String, percent: String) {
        circleView.backgroundColor = color
        titleLabel.text = title
        percentLabel.text = percent
        
        let percentAttributeString = NSMutableAttributedString(string: percent)
        percentAttributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: (percent as NSString).range(of: "%"))
        percentLabel.attributedText = percentAttributeString
    }
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        addSubview(circleView)
        addSubview(titleLabel)
        addSubview(percentLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        circleView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(9)
            $0.centerY.equalTo(titleLabel)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(circleView.snp.trailing).inset(-5)
        }
        percentLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
}
