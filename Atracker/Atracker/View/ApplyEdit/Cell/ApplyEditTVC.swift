//
//  ApplyEditTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/01.
//

import UIKit
import SnapKit

class ApplyEditTVC: BaseTVC {
    static let id = "ApplyEditTVC"
    
    let stackView = UIStackView()
    let checkButtonView = UIView()
    let checkButton = UIButton(type: .system)
    
    var editView: UIView?
    let qnaEditView = QNAEditView()
    
    var textChanged: ((String) -> Void)?
    
    func update(content: StageContent) {
        prepareForReuse()
//        
//        switch content.contentType {
//        case StageContentType.OVERALL.code:
//            editView = QNAEditView()
//            guard let editView = editView as? QNAEditView else { return }
//
//            editView.questionTextView.delegate = self
//            editView.answerTextView.delegate = self
//            editView.feedbackTextView.delegate = self
//            
//        case StageContentType.QNA.code:
//            editView = QNAEditView()
//        case StageContentType.FREE.code:
//            editView = QNAEditView()
//        default:
//            break
//        }
//        
//        guard let editView = editView else { return }
//
//        contentView.addSubview(editView)
//        
//        editView.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.bottom.equalToSuperview().inset(16)
//        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        backgroundColor = .clear
    }
    
    override func setupLayout() {
        super.setupLayout()
    }
    
    func textChanged(completion: @escaping (String) -> Void) {
        self.textChanged = completion
    }
}

extension ApplyEditTVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
