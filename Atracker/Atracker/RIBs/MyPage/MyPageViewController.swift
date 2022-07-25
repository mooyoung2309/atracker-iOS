//
//  MyPageViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs
import RxSwift
import UIKit

protocol MyPagePresentableAction: AnyObject {
    var tapSignOutButton: Observable<Void> { get }
}

protocol MyPagePresentableHandler: AnyObject {
    var myPage: Observable<MyPageResponse> { get }
}

protocol MyPagePresentableListener: AnyObject {
    func tapBackButton()
    func tapSignOutButton()
}

final class MyPageViewController: BaseNavigationViewController, MyPagePresentable, MyPageViewControllable {

    weak var listener: MyPagePresentableListener?
    
    weak var action: MyPagePresentableAction? {
        return self
    }
    
    weak var handler: MyPagePresentableHandler?
    
    let selfView = MyPageView()
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        guard let handler = handler else { return }
        
        handler.myPage
            .bind { [weak self] myPage in
                self?.didUpdateMyPage(myPage: myPage)
            }
            .disposed(by: disposeBag)
        
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
        
        selfView.withDrawButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapSignOutButton()
            }
            .disposed(by: disposeBag)
    }
    
    func didUpdateMyPage(myPage: MyPageResponse) {
        selfView.positionLabel.text = "\(myPage.jobPosition)"
        selfView.careerLabel.text = "\(myPage.experienceType.title)"
        
        let titleString = "\(myPage.nickName)님, 안녕하세요!"
        let titleAttributeString = NSMutableAttributedString(string: titleString)
        titleAttributeString.addAttribute(.foregroundColor, value: UIColor.neonGreen, range: (titleString as NSString).range(of: "\(myPage.nickName)"))
        
        selfView.welcomeLabel.attributedText = titleAttributeString
    }
}

extension MyPageViewController: MyPagePresentableAction {
    var tapSignOutButton: Observable<Void> {
        return selfView.signOutButton.rx.tap.asObservable()
    }
}
