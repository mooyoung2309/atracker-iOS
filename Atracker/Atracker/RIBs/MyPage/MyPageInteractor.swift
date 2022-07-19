//
//  MyPageInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs
import RxSwift
import RxCocoa

protocol MyPageRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
    var action: MyPagePresentableAction? { get }
    var handler: MyPagePresentableHandler? { get set }
}

protocol MyPageListener: AnyObject {
    func didSignOut()
}

final class MyPageInteractor: PresentableInteractor<MyPagePresentable>, MyPageInteractable, MyPagePresentableListener {

    weak var router: MyPageRouting?
    weak var listener: MyPageListener?

    private let userSerivce: UserServiceProtocol
    
    private let myPageRelay = PublishRelay<MyPageResponse>()
    
    init(presenter: MyPagePresentable, userService: UserServiceProtocol) {
        self.userSerivce = userService
        
        super.init(presenter: presenter)
        
        presenter.listener = self
        presenter.handler = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        fetchMyPage()
    }

    override func willResignActive() {
        super.willResignActive()
        
        presenter.handler = nil
    }
    
    func tapBackButton() {
        
    }
    
    func tapSignOutButton() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.accessToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.refreshToken)
        listener?.didSignOut()
    }
    
    func fetchMyPage() {
        userSerivce.myPage { [weak self] result in
            switch result {
            case .success(let data):
                self?.myPageRelay.accept(data)
            case .failure(let error):
                return
            }
        }
    }
}

extension MyPageInteractor: MyPagePresentableHandler {
    var myPage: Observable<MyPageResponse> {
        return myPageRelay.asObservable()
    }
}
