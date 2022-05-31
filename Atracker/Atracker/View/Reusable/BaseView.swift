//
//  BaseView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/30.
//

import UIKit

class BaseView: UIView {
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func setupProperty() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
}
