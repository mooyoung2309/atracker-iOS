//
//  ReviewContentTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

class ApplyContentTVC: UITableViewCell, UITextViewDelegate {
    static let id = "ApplyContentTVC"
    
    var stackView = UIStackView().then {
        $0.spacing = 0
    }
    var checkView = UIView().then {
        $0.backgroundColor = .clear
    }
    var checkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark"), for: .normal)
    }
    var writeView: UIView!
    
    var textChanged: ((String) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperty()
        setupHierarchy()
        setupLayout()
        showCheckButton(false)
    }
    
    override func prepareForReuse() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func update(apply: Apply) {
        if apply.type == "QA" {
            writeView = QAWriteView()
            guard let qaWriteView = writeView as? QAWriteView else { return }
            
            qaWriteView.questionTextField.text = apply.content
            qaWriteView.answerTextField.text = apply.content
            qaWriteView.reflectTextField.text = apply.content
            
            qaWriteView.questionTextField.delegate = self
            qaWriteView.answerTextField.delegate = self
            qaWriteView.reflectTextField.delegate = self
            
            stackView.addArrangedSubview(qaWriteView)
        } else if apply.type == "REVIEW" {
            writeView = ReviewWriteView()
            guard let reviewWriteView = writeView as? ReviewWriteView else { return }
            
            reviewWriteView.reflectTextField.text = apply.content
            reviewWriteView.reflectTextField.delegate = self
            stackView.addArrangedSubview(reviewWriteView)
        }
    }
    
    func showCheckButton(_ bool: Bool) {
        if bool {
            checkView.isHidden = false
        } else {
            checkView.isHidden = true
        }
    }
}

extension ApplyContentTVC {
    func setupHierarchy() {
        contentView.addSubview(stackView)
    }
    
    func setupLayout() {
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        checkView.snp.makeConstraints {
            $0.width.equalTo(15)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(15)
        }
    }
    
    func setupProperty() {
        backgroundColor = .backgroundGray
        
        if Bool.random() {
            writeView = QAWriteView()
        } else {
            writeView = ReviewWriteView()
        }
        
        stackView.addArrangedSubview(checkView)
        checkView.addSubview(checkButton)
    }
    
    func textChanged(action: @escaping (String) -> Void) {
            self.textChanged = action
        }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
