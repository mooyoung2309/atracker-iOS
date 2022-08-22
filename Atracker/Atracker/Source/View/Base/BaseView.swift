//
//  BaseView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/30.
//

import UIKit
import RxSwift
import RxCocoa

class BaseView: UIView {
    var disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupDelegate()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    func setupProperty() { }
    
    func setupDelegate() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
    
    func setupBind() { }
}
