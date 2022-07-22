//
//  SignUpSuccessViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpSuccessPresentableListener: AnyObject {
    
}

final class SignUpSuccessViewController: BaseNavigationViewController, SignUpSuccessPresentable, SignUpSuccessViewControllable {

    weak var listener: SignUpSuccessPresentableListener?
    
    let selfView = SignUpSuccessView()
    
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
    
    func showNickname(nickname: String) {
        selfView.titleLabel.text = "\(nickname)님,\n반갑습니다!"
    }
}
