//
//  SearchTextField.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/28.
//

import UIKit
import SnapKit
import RxDataSources

enum SearchTextFieldType {
    case company
    case jobPosition
    case jobType
    
    var headerTitle: String {
        switch self {
        case .company:
            return "회사명"
        case .jobPosition:
            return "포지션"
        case .jobType:
            return "근무 형태"
        }
    }
    
    var placeholderTitle: String {
        switch self {
        case .company:
            return "회사명을 입력해주세요."
        case .jobPosition:
            return "포지션명을 입력해주세요."
        case .jobType:
            return "근무 형태를 선택해주세요."
        }
    }
    
    var trailingButtonImage: UIImage? {
        switch self {
        case .company:
            return UIImage(named: ImageName.search)
        case .jobPosition:
            return nil
        case .jobType:
            return UIImage(named: ImageName.chevronDown)
        }
    }
}

class SearchTextField: BaseView, UITextFieldDelegate {
    
    // MARK: - UI Components
    
    let headerLabel: UILabel = .init()
    let textField: UITextField = .init()
    let underLine: UIView = .init()
    let trailingButton: UIButton = .init()
    let tableView: UITableView = .init()
    
    // MARK: - Properties
    
    let type: SearchTextFieldType
    
    // MARK: - Initializer
    
    init(type: SearchTextFieldType) {
        self.type = type
        
        super.init(frame: .zero)
        
        headerLabel.text = type.headerTitle
        
        textField.attributedPlaceholder = NSAttributedString(string: type.placeholderTitle, attributes: [.foregroundColor : UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .light)])
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods

    override func setupProperty() {
        super.setupProperty()
        
        headerLabel.font = .systemFont(ofSize: 14, weight: .medium)
        headerLabel.textColor = .gray3
        
        textField.tintColor = .neonGreen
        textField.textColor = .white
        
        underLine.backgroundColor = .gray3
        
        trailingButton.setImage(type.trailingButtonImage, for: .normal)
        trailingButton.setImage(UIImage(named: ImageName.cancle), for: .selected)
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        textField.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews(headerLabel, underLine, trailingButton, textField, tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        headerLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        trailingButton.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalTo(textField)
            $0.width.height.equalTo(18)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        underLine.backgroundColor = .neonGreen
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        underLine.backgroundColor = .gray3
    }
}
