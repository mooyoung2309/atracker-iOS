//
//  ResultTextField.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/22.
//

import UIKit
import SnapKit
import RxDataSources

class ResultTextField: BaseView, UITextFieldDelegate {
    
    // MARK: - UI Components
    
    let headerLabel: UILabel = .init()
    let textField: UITextField = .init()
    let underLine: UIView = .init()
    let trailingButton: UIButton = .init()
    
    // MARK: - Initializer
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(header: String, placeholder: String) {
        super.init(frame: .zero)
        
        headerLabel.text = header
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .light)])

    }
    
    // MARK: - Setup Methods

    override func setupProperty() {
        super.setupProperty()
        
        headerLabel.font = .systemFont(ofSize: 14, weight: .medium)
        headerLabel.textColor = .gray3
        
        textField.tintColor = .neonGreen
        textField.textColor = .white
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        textField.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews(headerLabel, underLine, trailingButton, textField)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        headerLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview()
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(3)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        trailingButton.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalTo(textField)
            $0.width.height.equalTo(18)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        underLine.backgroundColor = .neonGreen
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        underLine.backgroundColor = .gray3
    }
}
