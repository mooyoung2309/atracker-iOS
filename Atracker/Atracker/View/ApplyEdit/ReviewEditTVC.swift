//
//  ApplyEditTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/13.
//

import UIKit

class ReviewEditTVC: BaseTVC, UITextViewDelegate {
    static let id = "ReviewEditTVC"
    
    let stackView                   = UIStackView()
    let checkButtonView             = UIView()
    let checkButton                 = UIButton(type: .system)
    let qnaStageContentEditView     = QnaStageContentEditView()
    let freeStageContentEditView    = FreeStageContentEditView()
    
    var textChanged: ((String) -> Void)?
    var isChecked: ((Bool) -> Void)?
    
    override func prepareForReuse() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func update(stageContent: StageContent) {
        super.update()
        
        var editView: UIView
        
        switch stageContent.contentType {
        case StageContentType.qna.code:
            editView = qnaStageContentEditView
            qnaStageContentEditView.qTextView.text        = stageContent.content
            qnaStageContentEditView.aTextView.text        = stageContent.content
            qnaStageContentEditView.rTextView.text  = stageContent.content
            
            qnaStageContentEditView.qTextView.delegate = self
            qnaStageContentEditView.aTextView.delegate = self
            qnaStageContentEditView.rTextView.delegate = self
            break
        case StageContentType.free.code:
            editView = freeStageContentEditView
            freeStageContentEditView.fTextView.text = stageContent.content
            freeStageContentEditView.fTextView.delegate = self
            break
        default:
            editView = freeStageContentEditView
            break
        }
        
        stackView.addArrangedSubviews([checkButtonView, editView])
    }
    
    override func setupProperty() {
        backgroundColor = .backgroundGray
        
        stackView.spacing = 0
        
        checkButton.setImage(UIImage(named: ImageName.check), for: .normal)
        checkButton.setImage(UIImage(named: ImageName.check), for: .normal)
        checkButton.layer.borderColor   = UIColor.gray3.cgColor
        checkButton.layer.cornerRadius  = 3
        checkButton.layer.borderWidth   = 1
        checkButton.contentEdgeInsets   = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        checkButtonView.addSubview(checkButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(41)
            $0.centerY.equalToSuperview()
        }
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
