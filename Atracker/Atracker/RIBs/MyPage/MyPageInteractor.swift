//
//  MyPageInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs
import RxSwift

protocol MyPageRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MyPageListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func tapBackButtonFromChildRIB()
    func didSignOut()
}

final class MyPageInteractor: PresentableInteractor<MyPagePresentable>, MyPageInteractable, MyPagePresentableListener {

    weak var router: MyPageRouting?
    weak var listener: MyPageListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MyPagePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func tapBackButton() {
        Log("[D] 뒤로가기")
        listener?.tapBackButtonFromChildRIB()
    }
    
    func tapSignOutButton() {
        Log("[SIGNOUT] start")
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.accessToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.refreshToken)
        listener?.didSignOut()
        Log("[SIGNOUT] end")
    }
}
