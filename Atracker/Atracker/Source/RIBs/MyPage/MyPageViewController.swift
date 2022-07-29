//
//  MyPageViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs
import RxSwift
import UIKit
import ReactorKit

protocol MyPagePresentableAction: AnyObject {
    var tapSignOutButton: Observable<Void> { get }
}

protocol MyPagePresentableHandler: AnyObject {
    var myPage: Observable<MyPageResponse> { get }
}

//enum MyPagePresentableAction {
//    case viewWillAppear
//    case tapLogOutButton
//    case tapSignOutButton
//}

protocol MyPagePresentableListener: AnyObject {
    typealias Action = MyPagePresentableAction
    typealias State = MyPagePresentableState

    var action: ActionSubject<Action> { get }
    var state: Observable<State> { get }
    var currentState: State { get }

    func tapBackButton()
    func tapLogOutButton()
    func tapSignOutButton()
}

final class MyPageViewController: BaseNavigationViewController, MyPagePresentable, MyPageViewControllable {
    var action: MyPagePresentableAction? {
        return self
    }
    
    var handler: MyPagePresentableHandler?
    
    
    weak var listener: MyPagePresentableListener?
    let selfView = MyPageView()
    
    override func dismiss(_ rootViewController: ViewControllable? = nil, isTabBarShow: Bool) {
        dismiss(animated: false, completion: nil)
    }
    
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
        
        guard let listener = listener else { return }
        
//        bindActions(to: listener)
//        bindStates(from: listener)
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

        selfView.logOutButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapLogOutButton()
            }
            .disposed(by: disposeBag)

        selfView.signOutButton.rx.tap
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

//extension MyPageViewController {
//    func bindActions(to listner: MyPagePresentableListener) {
//        bindViewWillAppear(to: listner)
//        bindTapLogOutButton(to: listner)
//        bindTapSignOutButton(to: listner)
//    }
//
//    func bindViewWillAppear(to listner: MyPagePresentableListener) {
//        rx.viewWillAppear
//            .map { _ in () }
//            .map { .viewWillAppear }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//    }
//
//    func bindTapLogOutButton(to listner: MyPagePresentableListener) {
//        selfView.signOutButton.rx.tap
//            .map { .tapLogOutButton }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//    }
//
//    func bindTapSignOutButton(to listner: MyPagePresentableListener) {
//        selfView.withDrawButton.rx.tap
//            .map { .tapSignOutButton }
//            .bind(to: listner.action)
//            .disposed(by: disposeBag)
//    }
//}

//extension MyPageViewController {
//    func bindStates(from listner: MyPagePresentableListener) {
//        bindMyPageResponseState(from: listner)
//    }
//
//    func bindMyPageResponseState(from listner: MyPagePresentableListener) {
//        listner.state
//            .map { $0.myPageResponse }
//            .bind { [weak self] myPageResonse in
//                if let myPageResponse = myPageResonse {
//                    self?.didUpdateMyPage(myPage: myPageResponse)
//                }
//            }
//            .disposed(by: disposeBag)
//    }
//
//    func bindjj(from listner: MyPagePresentableListener) {
//        listner.state
//            .map { $0 }
//            .bind {
//
//            }
//    }
//}

extension MyPageViewController: MyPagePresentableAction {
    var tapSignOutButton: Observable<Void> {
        return selfView.logOutButton.rx.tap.asObservable()
    }
}
