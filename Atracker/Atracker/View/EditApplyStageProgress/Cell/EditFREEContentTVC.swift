//
//  EditFREEContentView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation
import UIKit

class EditFREEContentTVC: BaseTVC {
    static let id = "EditFREEContentTVC"
    
    let containerView = UIView()
    let titleTextView = UITextField()
    let contextTextView = UITextView()
    
    var textChanged: ((FreeContent) -> Void)?
    
    func update(freeContent: FreeContent) {
        titleTextView.text = freeContent.t
        contextTextView.text = freeContent.b
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleTextView.text = ""
        contextTextView.text = ""
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        containerView.backgroundColor = .backgroundLightGray
        containerView.layer.cornerRadius = 5
        
        backgroundColor = .clear
        
        titleTextView.delegate = self
        titleTextView.backgroundColor = .clear
        titleTextView.font = .systemFont(ofSize: 16, weight: .regular)
        titleTextView.text = "제목"
        titleTextView.textColor = .neonGreen
        
        contextTextView.delegate = self
        contextTextView.backgroundColor = .clear
        contextTextView.font = .systemFont(ofSize: 16, weight: .regular)
        contextTextView.tintColor = .neonGreen
        contextTextView.textColor = .white
        contextTextView.isScrollEnabled = false
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleTextView)
        containerView.addSubview(contextTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        titleTextView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        contextTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}

extension EditFREEContentTVC: UITextViewDelegate, UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let t = titleTextView.text ?? ""
        let b = contextTextView.text ?? ""
        
        textChanged?(FreeContent(t: t, b: b))
    }
    
    func textChanged(completion: @escaping (FreeContent) -> Void) {
            self.textChanged = completion
        }
    
    func textViewDidChange(_ textView: UITextView) {
        let t = titleTextView.text ?? ""
        let b = contextTextView.text ?? ""
        
        textChanged?(FreeContent(t: t, b: b))
    }
}
