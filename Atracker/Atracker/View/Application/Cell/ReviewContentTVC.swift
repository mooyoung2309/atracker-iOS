//
//  ReviewContentTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/24.
//

import UIKit
import SnapKit
import Then

class ReviewContentTVC: UITableViewCell {
    static let id = "ReviewContentTVC"
    
    var writeView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func update() {
        
    }
}

extension ReviewContentTVC {
    func setupHierarchy() {
        contentView.addSubview(writeView)
    }
    
    func setupLayout() {
        writeView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupProperty() {
        backgroundColor = .backgroundGray
        
        if Bool.random() {
            writeView = QuestionWriteView()
        } else {
            writeView = ReflectWriteView()
        }
    }
}
