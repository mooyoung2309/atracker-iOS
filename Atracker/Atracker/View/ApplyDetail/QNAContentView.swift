//
//  QNAContentView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/15.
//

import UIKit

class QNAContentView: BaseView {
    
    let questionTitleLabel = UILabel()
    let questionLabel = UILabel()
    let answerTitleLabel = UILabel()
    let answerLabel = UILabel()
    let feedbackLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(qnaContent: QNAContent) {
        super.init(frame: .zero)
        
        questionLabel.text = qnaContent.q
        answerLabel.text = qnaContent.a
        feedbackLabel.text = qnaContent.f
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        questionTitleLabel.text = "Q."
        questionTitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        questionTitleLabel.textColor = .neonGreen
        
        questionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        questionLabel.textColor = .white
        questionLabel.numberOfLines = 0
        
        answerTitleLabel.text = "A."
        answerTitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        answerTitleLabel.textColor = .neonGreen
        
        answerLabel.font = .systemFont(ofSize: 16, weight: .regular)
        answerLabel.textColor = .white
        answerLabel.numberOfLines = 0
        
        feedbackLabel.font = .systemFont(ofSize: 16, weight: .regular)
        feedbackLabel.textColor = .white
        feedbackLabel.numberOfLines = 0
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(questionTitleLabel)
        addSubview(questionLabel)
        addSubview(answerTitleLabel)
        addSubview(answerLabel)
        addSubview(feedbackLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        questionTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(questionTitleLabel)
            $0.leading.equalTo(questionTitleLabel.snp.trailing).inset(-8)
            $0.trailing.equalToSuperview()
        }
        
        answerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).inset(-28)
            $0.leading.equalToSuperview()
        }
        
        answerLabel.snp.makeConstraints {
            $0.top.equalTo(answerTitleLabel)
            $0.leading.equalTo(answerTitleLabel.snp.trailing).inset(-8)
            $0.trailing.equalToSuperview()
        }
        
        feedbackLabel.snp.makeConstraints {
            $0.top.equalTo(answerLabel.snp.bottom).inset(-28)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
