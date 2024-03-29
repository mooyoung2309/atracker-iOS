//
//  NewMyPageViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/29.
//

import RIBs
import RxSwift
import UIKit
import ReactorKit

enum MyPagePresentableAction {
    case viewWillAppear
    case tapLogOutButton
    case tapSignOutButton
}

protocol MyPagePresentableListener: AnyObject {
    typealias Action = MyPagePresentableAction
    typealias State = MyPagePresentableState

    var action: ActionSubject<Action> { get }
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class MyPageViewController: BaseNavigationViewController, MyPagePresentable, MyPageViewControllable {
    weak var listener: MyPagePresentableListener?
    let selfView = MyPageView()
    
    override func dismiss(_ rootViewController: ViewControllable? = nil, isTabBarShow: Bool) {
        dismiss(animated: false, completion: nil)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
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
        
        guard let listener = listener else { return }
        
        bindActions(to: listener)
        bindStates(from: listener)
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

extension MyPageViewController {
    func bindActions(to listner: MyPagePresentableListener) {
        bindViewWillAppear(to: listner)
        bindTapLogOutButton(to: listner)
        bindTapSignOutButton(to: listner)
    }

    func bindViewWillAppear(to listner: MyPagePresentableListener) {
        rx.viewWillAppear
            .map { _ in () }
            .map { .viewWillAppear }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
    }

    func bindTapLogOutButton(to listner: MyPagePresentableListener) {
        selfView.logOutButton.rx.tap
            .map { .tapLogOutButton }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
    }

    func bindTapSignOutButton(to listner: MyPagePresentableListener) {
        selfView.signOutButton.rx.tap
            .map { .tapSignOutButton }
            .bind(to: listner.action)
            .disposed(by: disposeBag)
    }
}

extension MyPageViewController {
    func bindStates(from listner: MyPagePresentableListener) {
        bindMyPageResponseState(from: listner)
    }

    func bindMyPageResponseState(from listner: MyPagePresentableListener) {
        listner.state
            .map { $0.myPageResponse }
            .bind { [weak self] myPageResonse in
                if let myPageResponse = myPageResonse {
                    self?.didUpdateMyPage(myPage: myPageResponse)
                }
            }
            .disposed(by: disposeBag)
    }
}
