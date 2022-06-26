//
//  SignUpPositionView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import Foundation
import UIKit
import SnapKit

class SignUpPositionView: BaseView {
    
    let titleLabel                      = UILabel()
    let positionLabel                   = UILabel()
    let positionUnderLineTextFieldView  = UnderLineTextFieldView()
    let careerLabel                     = UILabel()
    let careerUnderLineTextFieldView    = UnderLineLabelView()
    let bottomNextButtonView            = BottomNextButtonView()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "어떤 포지션으로 취업하고 싶으신가요?"
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .white
        
        positionLabel.text      = "이름"
        positionLabel.font      = .systemFont(ofSize: 14, weight: .medium)
        positionLabel.textColor = .gray3
        
//        positionUnderLineTextFieldView.textField.placeholder = "포지션명을 입력해주세요."
        positionUnderLineTextFieldView.textField.attributedPlaceholder = NSAttributedString(string: "포지션명을 입력해주세요.", attributes: [.foregroundColor : UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .light)])
        
        careerLabel.text = "경력"
        careerLabel.font      = .systemFont(ofSize: 14, weight: .medium)
        careerLabel.textColor = .gray3
        
        careerUnderLineTextFieldView.label.text = "경력을 선택해 주세요."
        careerUnderLineTextFieldView.label.font = .systemFont(ofSize: 16, weight: .light)
        careerUnderLineTextFieldView.button.isHidden = false
        careerUnderLineTextFieldView.button.setImage(UIImage(named: ImageName.chevronDown)?.withTintColor(.gray5), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(titleLabel)
        addSubview(positionLabel)
        addSubview(positionUnderLineTextFieldView)
        addSubview(careerLabel)
        addSubview(careerUnderLineTextFieldView)
        addSubview(bottomNextButtonView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }
        
        positionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-37)
            $0.leading.equalToSuperview().inset(28)
        }
        
        positionUnderLineTextFieldView.snp.makeConstraints {
            $0.top.equalTo(positionLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        careerLabel.snp.makeConstraints {
            $0.top.equalTo(positionUnderLineTextFieldView.snp.bottom).inset(-37)
            $0.leading.equalToSuperview().inset(28)
        }
        
        careerUnderLineTextFieldView.snp.makeConstraints {
            $0.top.equalTo(careerLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        bottomNextButtonView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
