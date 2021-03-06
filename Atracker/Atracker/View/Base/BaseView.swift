//
//  BaseView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/30.
//

import UIKit
import RxSwift
import RxCocoa

protocol BaseViewProtocol {
    func setupProperty()
    func setupHierarchy()
    func setupLayout()
}

class BaseView: UIView, BaseViewProtocol {
    let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
