//
//  QuestionEditView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/25.
//

import UIKit
import SnapKit
import Then

class QAWriteView: UIView, UITextViewDelegate {
    let questionView = UIView().then {
        $0.backgroundColor = .backgroundLightGray
        $0.layer.cornerRadius = 5
    }
    let questionLabel = UILabel().then {
        $0.text = "Q."
        $0.textColor = .neonGreen
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.sizeToFit()
    }
    let questionTextField = UITextView().then {
        $0.text = "질문"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.backgroundColor = .backgroundLightGray
        $0.isScrollEnabled = false
    }
    let answerView = UIView().then {
        $0.backgroundColor = .backgroundLightGray
        $0.layer.cornerRadius = 5
    }
    let answerLabel = UILabel().then {
        $0.text = "A."
        $0.textColor = .neonGreen
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.sizeToFit()
    }
    let answerTextField = UITextView().then {
        $0.text = "대답"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.backgroundColor = .backgroundLightGray
        $0.isScrollEnabled = false
    }
    let reflectView = UIView().then {
        $0.backgroundColor = .backgroundLightGray
        $0.layer.cornerRadius = 5
    }
    let reflectLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .neonGreen
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.sizeToFit()
    }
    let reflectTextField = UITextView().then {
        $0.text = ""
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
        setupHierarchy()
        setupLayout()
        setupProperty()
    }
}

extension QAWriteView {
    func setupHierarchy() {
        addSubview(questionView)
        questionView.addSubview(questionLabel)
        questionView.addSubview(questionTextField)
        addSubview(answerView)
        answerView.addSubview(answerLabel)
        answerView.addSubview(answerTextField)
        addSubview(reflectView)
        reflectView.addSubview(reflectLabel)
        reflectView.addSubview(reflectTextField)
    }
    
    func setupLayout() {
        questionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(20)
        }
        
        questionTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.5)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(36)
            $0.trailing.equalTo(snp.trailing).inset(11)
        }
        
        answerView.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview()
        }
        
        answerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(20)
        }
        
        answerTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.5)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(36)
            $0.trailing.equalTo(snp.trailing).inset(11)
        }
        
        reflectView.snp.makeConstraints {
            $0.top.equalTo(answerView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        reflectLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(20)
        }
        
        reflectTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.5)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(36)
            $0.trailing.equalTo(snp.trailing).inset(11)
        }
    }
    
    func setupProperty() {
        backgroundColor = .backgroundGray
        questionTextField.delegate = self
        answerTextField.delegate = self
        reflectTextField.delegate = self
    }
    
    func textChanged(action: @escaping (String) -> Void) {
            self.textChanged = action
        }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
