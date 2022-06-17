//
//  FreeStageContentEditView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/16.
//

import UIKit
import SnapKit
import Then

class FreeStageContentEditView: BaseView {
    
    let fView       = UIView()
    let fLabel      = UILabel()
    let fTextView   = UITextView()
    
    override func setupProperty() {
        super.setupProperty()
        
        fView.backgroundColor = .backgroundLightGray
        fView.layer.cornerRadius = 5
        
        fLabel.text = "후기"
        fLabel.textColor = .neonGreen
        fLabel.font = .systemFont(ofSize: 16, weight: .bold)
        fLabel.sizeToFit()
        
        fTextView.text = "222"
        fTextView.textColor = .white
        fTextView.font = .systemFont(ofSize: 13, weight: .regular)
        fTextView.backgroundColor = .backgroundLightGray
        fTextView.isScrollEnabled = false
        
        backgroundColor = .backgroundGray
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(fView)
        fView.addSubview(fLabel)
        fView.addSubview(fTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        fView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        fLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.height.equalTo(26)
        }
        
        fTextView.snp.makeConstraints {
            $0.top.equalTo(fLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
