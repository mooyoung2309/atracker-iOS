//
//  SignUpPositionViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpPositionPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SignUpPositionViewController: BaseNavigationViewController, SignUpPositionPresentable, SignUpPositionViewControllable {

    weak var listener: SignUpPositionPresentableListener?
    
    let selfView = SignUpPositionView()
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        hideNavigationBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
