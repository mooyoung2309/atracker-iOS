//
//  QNAEditView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/01.
//

import UIKit
import SnapKit

class QNAEditView: BaseView {
    
    let questionLabel       = UILabel()
    let questionTextView    = UITextView()
    let questionDivider     = Divider(.backgroundGray)
    let answerLabel         = UILabel()
    let answerTextView      = UITextView()
    let answerDivider       = Divider(.backgroundGray)
    let feedbackTextView    = UITextView()
    
    var textChanged: ((String) -> Void)?
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 5
        backgroundColor = .backgroundLightGray
        
        questionLabel.text = "Q."
        questionLabel.font = .systemFont(ofSize: 18, weight: .regular)
        questionLabel.textColor = .neonGreen
        
        questionTextView.text = "질문"
        questionTextView.font = .systemFont(ofSize: 16, weight: .regular)
        questionTextView.textColor = .white
        questionTextView.backgroundColor = .clear
        questionTextView.isScrollEnabled = false
        
        answerLabel.text = "A."
        answerLabel.font = .systemFont(ofSize: 18, weight: .regular)
        answerLabel.textColor = .neonGreen
        
        answerTextView.text = "답변"
        answerTextView.font = .systemFont(ofSize: 16, weight: .regular)
        answerTextView.textColor = .white
        answerTextView.backgroundColor = .clear
        answerTextView.isScrollEnabled = false
        answerTextView.showsHorizontalScrollIndicator = false
        answerTextView.showsVerticalScrollIndicator = false
        
        feedbackTextView.text = "테스트"
        feedbackTextView.font = .systemFont(ofSize: 16, weight: .regular)
        feedbackTextView.textColor = .gray2
        feedbackTextView.backgroundColor = .clear
        feedbackTextView.isScrollEnabled = false
        feedbackTextView.showsHorizontalScrollIndicator = false
        feedbackTextView.showsVerticalScrollIndicator = false
        
        questionTextView.delegate = self
        answerTextView.delegate = self
        feedbackTextView.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(questionLabel)
        addSubview(questionTextView)
        addSubview(questionDivider)
        addSubview(answerLabel)
        addSubview(answerTextView)
        addSubview(answerDivider)
        addSubview(feedbackTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(13)
        }
        
        questionTextView.snp.makeConstraints {
            $0.top.equalTo(questionLabel).inset(-6)
            $0.leading.equalTo(questionLabel.snp.trailing).inset(-5)
            $0.trailing.equalToSuperview().inset(13)
        }
        
        questionDivider.snp.makeConstraints {
            $0.top.equalTo(questionTextView.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview()
        }
        
        answerLabel.snp.makeConstraints {
            $0.top.equalTo(questionDivider.snp.bottom).inset(-16)
            $0.leading.equalToSuperview().inset(13)
        }
        
        answerTextView.snp.makeConstraints {
            $0.top.equalTo(answerLabel).inset(-6)
            $0.leading.equalTo(answerLabel.snp.trailing).inset(-5)
            $0.trailing.equalToSuperview().inset(13)
        }
        
        answerDivider.snp.makeConstraints {
            $0.top.equalTo(answerTextView.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview()
        }
        
        feedbackTextView.snp.makeConstraints {
            $0.top.equalTo(answerDivider.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}

extension QNAEditView: UITextViewDelegate {
    func textChanged(action: @escaping (String) -> Void) {
            self.textChanged = action
        }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}

