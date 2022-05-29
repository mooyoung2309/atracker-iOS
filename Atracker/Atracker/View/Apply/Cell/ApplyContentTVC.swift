//
//  ReviewContentTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

class ApplyContentTVC: UITableViewCell {
    static let id = "ReviewContentTVC"
    
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
    
    func update() {
        
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
//
//        writeView.snp.makeConstraints {
//            $0.top.leading.trailing.bottom.equalToSuperview()
//        }
    }
    
    func setupProperty() {
        backgroundColor = .backgroundGray
        
        if Bool.random() {
            writeView = QuestionWriteView()
        } else {
            writeView = ReflectWriteView()
        }
        
        stackView.addArrangedSubviews([checkView, writeView])
        checkView.addSubview(checkButton)
    }
}
