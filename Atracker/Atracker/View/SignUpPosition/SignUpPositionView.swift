//
//  SignUpPositionView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import UIKit
import SnapKit

class SignUpPositionView: BaseView {
    
    let titleLabel = UILabel()
    let positionUnderLineTextFieldView = UnderLineTextFieldView(title: "포지션", placeholder: "포지션명을 입력해주세요.")
    let careerUnderLineLabelView = UnderLineLabelView(title: "경력", placeholder: "경력을 선택해 주세요.")
    let carrerTableView = UITableView()
    let bottomNextButtonView = BottomNextButtonView()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "어떤 포지션으로 취업하고 싶으신가요?"
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .white
        
        careerUnderLineLabelView.button.isHidden = false
        careerUnderLineLabelView.button.setImage(UIImage(named: ImageName.chevronDown)?.withTintColor(.gray5), for: .normal)
        
        carrerTableView.register(SearchTVC.self, forCellReuseIdentifier: SearchTVC.id)
        carrerTableView.backgroundColor = .backgroundLightGray
        carrerTableView.isScrollEnabled = false
        carrerTableView.isHidden = true
        
        bottomNextButtonView.backgroundColor = .backgroundGray
        bottomNextButtonView.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(titleLabel)
        addSubview(positionUnderLineTextFieldView)
        addSubview(careerUnderLineLabelView)
        addSubview(carrerTableView)
        addSubview(bottomNextButtonView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }
        
        positionUnderLineTextFieldView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(28)
        }

        careerUnderLineLabelView.snp.makeConstraints {
            $0.top.equalTo(positionUnderLineTextFieldView.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        carrerTableView.snp.makeConstraints {
            $0.top.equalTo(careerUnderLineLabelView.snp.bottom)
            $0.leading.trailing.equalTo(careerUnderLineLabelView)
            $0.height.equalTo(0)
        }
        
        bottomNextButtonView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
