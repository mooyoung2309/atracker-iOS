//
//  MyPageViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs
import RxSwift
import UIKit

protocol MyPagePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func tapBackButton()
    func tapSignOutButton()
}

final class MyPageViewController: BaseNavigationViewController, MyPagePresentable, MyPageViewControllable {

    weak var listener: MyPagePresentableListener?
    
    let selfView = MyPageView()
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        setNavigaionBarTitle("마이페이지")
        showNavigationBarBackButton()
        showNavigationBar()
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
        
        selfView.signOutButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapSignOutButton()
            }
            .disposed(by: disposeBag)
    }
}
