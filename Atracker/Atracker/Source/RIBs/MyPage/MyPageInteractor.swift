//
//  NewMyPageInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/29.
//

import RIBs
import RxSwift
import ReactorKit

protocol MyPageRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MyPageListener: AnyObject {
    func detachSignInRIB()
}

final class MyPageInteractor: PresentableInteractor<MyPagePresentable>, MyPageInteractable, MyPagePresentableListener, Reactor {
    typealias Action = MyPagePresentableAction
    typealias State = MyPagePresentableState
    
    enum Mutation {
        case myPageResponse(MyPageResponse)
        case detach
    }
    
    var initialState: MyPagePresentableState
    
    weak var router: MyPageRouting?
    weak var listener: MyPageListener?
    
    let authService: AuthServiceProtocol
    let userService: UserServiceProtocol
    
    init(presenter: MyPagePresentable, authService: AuthServiceProtocol, userService: UserServiceProtocol) {
        self.authService = authService
        self.userService = userService
        
        self.initialState = .init(myPageResponse: nil)
        
        super.init(presenter: presenter)
        
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return Observable<Mutation>.create { emitter in
                self.userService.myPage { result in
                    switch result {
                    case .success(let data): emitter.onNext(.myPageResponse(data))
                    case .failure: break
                    }
                }
                return Disposables.create()
            }
        case .tapLogOutButton:
            authService.logOut()
            return .just(.detach)
        case .tapSignOutButton:
            return Observable<Mutation>.create { emitter in
                self.authService.signOut { result in
                    switch result {
                    case .success: emitter.onNext(.detach)
                    case .failure: break
                    }
                }
                return Disposables.create()
            }
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
       return mutation
         .flatMap { [weak self] mutation -> Observable<Mutation> in
             guard let this = self else { return .empty() }
             switch mutation {
             case .detach:
             return this.detachSignInRIBTransform()
           default:
             return .just(mutation)
           }
         }
     }

    func reduce(state: State, mutation: Mutation) -> MyPagePresentableState {
        var newState = state
        switch mutation {
        case .myPageResponse(let myPageResponse):
            newState.myPageResponse = myPageResponse
        default:
            break
        }
        return newState
    }
    
    private func detachSignInRIBTransform() -> Observable<Mutation> {
        listener?.detachSignInRIB()
        return .empty()
    }
}
