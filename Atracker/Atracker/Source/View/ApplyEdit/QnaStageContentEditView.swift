//
//  QnaReviewEditView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/16.
//

import UIKit
import SnapKit
import Then

class QnaStageContentEditView: BaseView {
    
    let qView = UIView()
    let qLabel = UILabel()
    let qTextView = UITextView()
    
    let aView = UIView()
    let aLabel = UILabel()
    let aTextView = UITextView()
    
    let rView = UIView()
    let rLabel = UILabel()
    let rTextView = UITextView()
    
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
    
    override func setupProperty() {
        super.setupProperty()
        
        qView.backgroundColor = .backgroundLightGray
        qView.layer.cornerRadius = 5
        
        qLabel.text = "Q."
        qLabel.textColor = .neonGreen
        qLabel.font = .systemFont(ofSize: 16, weight: .bold)
        qLabel.sizeToFit()
        
        qTextView.text = "질문"
        qTextView.textColor = .white
        qTextView.font = .systemFont(ofSize: 13, weight: .regular)
        qTextView.backgroundColor = .backgroundLightGray
        qTextView.isScrollEnabled = false
        
        aView.backgroundColor = .backgroundLightGray
        aView.layer.cornerRadius = 5
        
        aLabel.text = "A."
        aLabel.textColor = .neonGreen
        aLabel.font = .systemFont(ofSize: 16, weight: .bold)
        aLabel.sizeToFit()
        
        aTextView.text = "대답"
        aTextView.textColor = .white
        aTextView.font = .systemFont(ofSize: 13, weight: .regular)
        aTextView.backgroundColor = .backgroundLightGray
        aTextView.isScrollEnabled = false
        
        rView.backgroundColor = .backgroundLightGray
        rView.layer.cornerRadius = 5
        
        rLabel.text = ""
        rLabel.textColor = .neonGreen
        rLabel.font = .systemFont(ofSize: 16, weight: .bold)
        rLabel.sizeToFit()
        
        rTextView.text = ""
        rTextView.textColor = .white
        rTextView.font = .systemFont(ofSize: 13, weight: .regular)
        rTextView.backgroundColor = .backgroundLightGray
        rTextView.isScrollEnabled = false
        
        backgroundColor = .backgroundGray
        qTextView.delegate = self
        aTextView.delegate = self
        rTextView.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(qView)
        qView.addSubview(qLabel)
        qView.addSubview(qTextView)
        
        addSubview(aView)
        aView.addSubview(aLabel)
        aView.addSubview(aTextView)
        
        addSubview(rView)
        rView.addSubview(rLabel)
        rView.addSubview(rTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        qView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        qLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(20)
        }
        
        qTextView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.5)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(36)
            $0.trailing.equalTo(snp.trailing).inset(11)
        }
        
        aView.snp.makeConstraints {
            $0.top.equalTo(qView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview()
        }
        
        aLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(20)
        }
        
        aTextView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.5)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(36)
            $0.trailing.equalTo(snp.trailing).inset(11)
        }
        
        rView.snp.makeConstraints {
            $0.top.equalTo(aView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        rLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(20)
        }
        
        rTextView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.5)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(36)
            $0.trailing.equalTo(snp.trailing).inset(11)
        }
    }
}

extension QnaStageContentEditView: UITextViewDelegate {
    func textChanged(action: @escaping (String) -> Void) {
            self.textChanged = action
        }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}

