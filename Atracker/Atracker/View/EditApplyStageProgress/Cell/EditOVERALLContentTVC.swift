//
//  EditOverallContentTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation
import UIKit

class EditOVERALLContentTVC: BaseTVC {
    static let id = "EditOverallContentTVC"
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let textView = UITextView()
    
    var textChanged: ((String) -> Void)?
    
    func update(overallContent: OVERALLContent) {
        textView.text = overallContent
    }
    
    override func prepareForReuse() {
        textView.text = ""
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        containerView.backgroundColor = .backgroundLightGray
        containerView.layer.cornerRadius = 5
        
        backgroundColor = .clear
        
        titleLabel.text = "종합 후기"
        titleLabel.textColor = .gray3
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.tintColor = .neonGreen
        textView.textColor = .white
        textView.isScrollEnabled = false
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(textView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}

extension EditOVERALLContentTVC: UITextViewDelegate {
    func textChanged(completion: @escaping (String) -> Void) {
            self.textChanged = completion
        }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
