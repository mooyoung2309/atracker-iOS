//
//  BaseCVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/14.
//

import UIKit
import SnapKit
import Then

class BaseCVC: UICollectionViewCell, BaseViewProtocol {
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func update() { }
    
    func setupProperty() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
}

