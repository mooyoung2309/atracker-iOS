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
    var editView                    = UIView()
    
    var textChanged: ((String) -> Void)?
    var isChecked: ((Bool) -> Void)?
    
    override func prepareForReuse() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func update(stageContent: StageContent) {
        super.update()
        
        switch stageContent.contentType {
        case StageContentType.QNA.code:
            editView = qnaStageContentEditView
            qnaStageContentEditView.qTextView.text        = stageContent.content
            qnaStageContentEditView.aTextView.text        = stageContent.content
            qnaStageContentEditView.rTextView.text  = stageContent.content
            
            qnaStageContentEditView.qTextView.delegate = self
            qnaStageContentEditView.aTextView.delegate = self
            qnaStageContentEditView.rTextView.delegate = self
            break
        case StageContentType.FREE.code:
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
    
    func showCheckButton() {
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        stackView.addArrangedSubviews([checkButtonView, editView])
    }
    
    func hideCheckButton() {
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        stackView.addArrangedSubviews([editView])
    }
    
    override func setupProperty() {
        backgroundColor = .backgroundGray
        
        stackView.spacing = 0
        
        let selectedImage   = UIImage(named: ImageName.selectedCheckBox)?.withTintColor(.neonGreen, renderingMode: .alwaysOriginal)
        
        checkButton.setImage(UIImage(named: ImageName.checkBox), for: .normal)
        checkButton.setImage(selectedImage, for: .highlighted)
        checkButton.setImage(selectedImage, for: .selected)
        checkButton.layer.borderColor   = UIColor.gray3.cgColor
        checkButton.contentEdgeInsets   = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 13)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        checkButtonView.addSubview(checkButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
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
