//
//  LoggedOutViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import Then

protocol LoggedOutPresentableListener: AnyObject {
    func login(withEmail: String?, _ password: String?)
}

final class LoggedOutViewController: BaseNavigationViewController, LoggedOutPresentable, LoggedOutViewControllable {
    
    weak var listener: LoggedOutPresentableListener?
    
    let selfView = LoggedOutView()
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        hideNavigationBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .backgroundGray
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        selfView.testLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.login(withEmail: "ddd", "ddd")
            })
            .disposed(by: disposeBag)
    }
}
