//
//  StatusEditBarView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/14.
//

import UIKit
import SnapKit

class StageStatusButtonBar: BaseView {
    
    let buttonStackView     = UIStackView()
    let notStartedButton    = RoundButton(type: .custom)
    let failButton          = RoundButton(type: .custom)
    let passButton          = RoundButton(type: .custom)
    let editButton          = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        buttonStackView.spacing       = 8
        buttonStackView.distribution  = .fillEqually
        buttonStackView.addArrangedSubviews([notStartedButton, failButton, passButton])
        
        notStartedButton.setTitle(StageProgressStatus.notStarted.rawValue, for: .normal)
        
        failButton.setTitle(StageProgressStatus.fail.rawValue, for: .normal)
        
        passButton.setTitle(StageProgressStatus.pass.rawValue, for: .normal)
        passButton.setColor(color: .neonGreen)
        
        editButton.setTitle("편집", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(buttonStackView)
        addSubview(editButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        buttonStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(211)
            $0.height.equalTo(26)
        }
        
        editButton.snp.makeConstraints {
            $0.centerY.equalTo(buttonStackView)
            $0.trailing.equalToSuperview()
        }
    }
}
