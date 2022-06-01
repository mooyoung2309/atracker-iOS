//
//  ReviewContentTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import Then

class ApplyContentTVC: UITableViewCell, UITextViewDelegate {
    var disposeBag = DisposeBag()
    static let id = "ApplyContentTVC"
    
    var stackView = UIStackView().then {
        $0.spacing = 10
    }
    var checkView = UIView().then {
        $0.backgroundColor = .clear
    }
    var checkButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: ImageName.check), for: .normal)
        $0.layer.borderColor = UIColor.gray3.cgColor
        $0.layer.cornerRadius = 3
        $0.layer.borderWidth = 1
    }
    var writeView: UIView!
    
    var textChanged: ((String) -> Void)?
    var isChecked: ((Bool) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    override func prepareForReuse() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func update(apply: Apply) {
        stackView.addArrangedSubview(checkView)
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
        
        if apply.isEditing {
            checkView.isHidden = false
        } else {
            checkView.isHidden = true
        }
        
        if apply.isChecked {
            checkButton.tintColor = .neonGreen
//            checkButton.isSelected = true
        } else {
            checkButton.tintColor = .clear
//            checkButton.isSelected = false
        }
    }
}

extension ApplyContentTVC {
    func setupProperty() {
        backgroundColor = .backgroundGray
        checkView.addSubview(checkButton)
    }
    
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
            $0.top.equalToSuperview().inset(13)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(15)
        }
    }
    
    func setupBind() {
        checkButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.isChecked?(true)
            }
            .disposed(by: disposeBag)
    }
    
    func textChanged(action: @escaping (String) -> Void) {
            self.textChanged = action
        }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
    
    func isChecked(completion: @escaping (Bool) -> Void) {
        self.isChecked = completion
    }
}
