//
//  SignUpNicknameViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpNicknamePresentableListener: AnyObject {
    func tapBackButton()
    func tapNextButton()
    func inputNicknameTextField(text: String)
}

final class SignUpNicknameViewController: BaseNavigationViewController, SignUpNicknamePresentable, SignUpNicknameViewControllable {
    
    weak var listener: SignUpNicknamePresentableListener?
    
    let selfView = SignUpNicknameView()
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        hideNavigationBarShadow()
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
    
    override func setupBind() {
        super.setupBind()
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
        
        selfView.bottomNextButtonView.button.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapNextButton()
            }
            .disposed(by: disposeBag)
        
        selfView.nicknameUnderLineTextFieldView.textField.rx.controlEvent([.editingDidBegin])
            .asObservable()
            .bind { [weak self] _ in
                self?.selfView.nicknameUnderLineTextFieldView.isHighlight = true
            }
            .disposed(by: disposeBag)
        
        selfView.nicknameUnderLineTextFieldView.textField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .bind { [weak self] _ in
                self?.selfView.nicknameUnderLineTextFieldView.isHighlight = false
            }
            .disposed(by: disposeBag)
        
        selfView.nicknameUnderLineTextFieldView.textField.rx.text
            .bind { [weak self] text in
                if let text = text {
                    self?.listener?.inputNicknameTextField(text: text)
                }
            }
            .disposed(by: disposeBag)
    }
}
