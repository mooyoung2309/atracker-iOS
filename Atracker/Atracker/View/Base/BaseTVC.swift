//
//  BaseTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/01.
//

import UIKit
import SnapKit
import Then

class BaseTVC: UITableViewCell, BaseViewProtocol {
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    func setupProperty() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
    
    func setupBind() { }
}
