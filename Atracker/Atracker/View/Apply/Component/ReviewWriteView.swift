//
//  ReviewEditView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/25.
//

import UIKit
import SnapKit
import Then

class ReviewWriteView: UIView, UITextViewDelegate {
    let reflectView = UIView().then {
        $0.backgroundColor = .backgroundLightGray
        $0.layer.cornerRadius = 5
    }
    let reflectLabel = UILabel().then {
        $0.text = "후기"
        $0.textColor = .neonGreen
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.sizeToFit()
    }
    let reflectTextField = UITextView().then {
        $0.text = "222"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.backgroundColor = .backgroundLightGray
        $0.isScrollEnabled = false
    }
    
    var textChanged: ((String) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
}

extension ReviewWriteView {
    func setupHierarchy() {
        addSubview(reflectView)
        reflectView.addSubview(reflectLabel)
        reflectView.addSubview(reflectTextField)
    }
    
    func setupLayout() {
        reflectView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        reflectLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.height.equalTo(26)
        }
        
        reflectTextField.snp.makeConstraints {
            $0.top.equalTo(reflectLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    func setupProperty() {
        backgroundColor = .backgroundGray
        reflectTextField.delegate = self
        
    }
    
    func textChanged(action: @escaping (String) -> Void) {
            self.textChanged = action
        }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
