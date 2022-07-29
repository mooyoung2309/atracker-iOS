//
//  EditQNAContentTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation
import UIKit

class EditQNAContentTVC: BaseTVC {
    static let id = "EditQNAContentTVC"
    
    let containerView = UIView()
    let questionLabel = UILabel()
    let questionTextView = UITextView()
    let questionDivider = Divider(.backgroundGray)
    let answerLabel = UILabel()
    let answerTextView = UITextView()
    let answerDivider = Divider(.backgroundGray)
    let feedbackTextView = UITextView()
    
    var textChanged: ((QNAContent) -> Void)?
    
    func update(qnaContent: QNAContent) {
        questionTextView.text = qnaContent.q
        answerTextView.text = qnaContent.a
        feedbackTextView.text = qnaContent.f
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        questionTextView.text = ""
        answerTextView.text = ""
        feedbackTextView.text = ""
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        containerView.backgroundColor = .backgroundLightGray
        containerView.layer.cornerRadius = 5
        
        backgroundColor = .clear
        
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
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(questionLabel)
        containerView.addSubview(questionTextView)
        containerView.addSubview(questionDivider)
        containerView.addSubview(answerLabel)
        containerView.addSubview(answerTextView)
        containerView.addSubview(answerDivider)
        containerView.addSubview(feedbackTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
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

extension EditQNAContentTVC: UITextViewDelegate {
    func textChanged(action: @escaping (QNAContent) -> Void) {
            self.textChanged = action
        }
    
    func textViewDidChange(_ textView: UITextView) {
        let q = questionTextView.text ?? ""
        let a = answerTextView.text ?? ""
        let f = feedbackTextView.text ?? ""
        
        textChanged?(QNAContent(a: a, q: q, f: f))
    }
}
