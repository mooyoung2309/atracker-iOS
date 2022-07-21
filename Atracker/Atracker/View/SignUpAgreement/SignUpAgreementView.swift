//
//  SignUpAgreementView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import UIKit

class SignUpAgreementView: BaseView {
    
    let titleLabel = UILabel()
    let titleDivider = Divider(.gray7)
    let allAgreementView = AgreementView(ageementType: AgreementType.all)
    let serviceAgreementView = AgreementView(ageementType: AgreementType.service)
    let personalAgreementView = AgreementView(ageementType: AgreementType.personal)
    let marketingAgreementView = AgreementView(ageementType: AgreementType.marketing)
    let nextButton = UIButton(type: .custom)
    
    override func setupProperty() {
        super.setupProperty()
        titleLabel.text = "서비스 이용 동의"
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .white
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.neonGreen, for: .selected)
        nextButton.setTitleColor(.gray3, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        nextButton.backgroundColor = .backgroundGray
        nextButton.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        addSubview(titleLabel)
        addSubview(allAgreementView)
        addSubview(serviceAgreementView)
        addSubview(personalAgreementView)
        addSubview(marketingAgreementView)
        addSubview(nextButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        allAgreementView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-14)
            $0.leading.trailing.equalToSuperview()
        }
        serviceAgreementView.snp.makeConstraints {
            $0.top.equalTo(allAgreementView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        personalAgreementView.snp.makeConstraints {
            $0.top.equalTo(serviceAgreementView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        marketingAgreementView.snp.makeConstraints {
            $0.top.equalTo(personalAgreementView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
