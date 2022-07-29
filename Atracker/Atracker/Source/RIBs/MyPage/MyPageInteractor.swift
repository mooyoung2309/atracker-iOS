//
//  MyPageInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs
import RxSwift
import RxCocoa
import ReactorKit

protocol MyPageRouting: ViewableRouting {
//    func detachThisRIB()
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
    var action: MyPagePresentableAction? { get }
    var handler: MyPagePresentableHandler? { get set }
}

protocol MyPageListener: AnyObject {
    func didSignOut()
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
    
    private let userSerivce: UserServiceProtocol
    private let authService: AuthServiceProtocol
    
    private let myPageRelay = PublishRelay<MyPageResponse>()
    
    init(initialState: MyPagePresentableState, presenter: MyPagePresentable, authService: AuthServiceProtocol ,userService: UserServiceProtocol) {
        self.initialState = initialState
        self.authService = authService
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
        listener = nil
        presenter.handler = nil
    }
    
    func tapBackButton() {
        
    }
    
    func tapLogOutButton() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.accessToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.refreshToken)
        listener?.didSignOut()
    }
    
    func tapSignOutButton() {
        authService.signOut { [weak self] result in
            switch result {
            case .success(_):
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.accessToken)
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.refreshToken)
                self?.listener?.didSignOut()
            case .failure(_):
                break
            }
        }
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
    
//    func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//        case .viewWillAppear:
//            return Observable<Mutation>.create { emitter in
//                self.userSerivce.myPage { result in
//                    switch result {
//                    case .success(let data):
//                        emitter.onNext(.myPageResponse(data))
//                        break
//                    case .failure: break
//                    }
//                }
//                return Disposables.create()
//            }
//        case .tapLogOutButton:
//            return .just(.detach)
//        case .tapSignOutButton:
//            return .just(.detach)
//        }
//    }
    
//    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
//       return mutation
//         .flatMap { [weak self] mutation -> Observable<Mutation> in
//             guard let this = self else { return .empty() }
//             switch mutation {
//             case .detach:
//             return this.attachUserInformationRIBTransform()
//           default:
//             return .just(mutation)
//           }
//         }
//     }
//    
//    func reduce(state: State, mutation: Mutation) -> MyPagePresentableState {
//        var newState = state
//        switch mutation {
//        case .myPageResponse(let myPageResponse):
//            newState.myPageResponse = myPageResponse
//        default:
//            break
//        }
//        return newState
//    }
    
//    private func attachUserInformationRIBTransform() -> Observable<Mutation> {
//        tapLogOutButton()
//        return .empty()
//    }
    
 
}

extension MyPageInteractor: MyPagePresentableHandler {
    var myPage: Observable<MyPageResponse> {
        return myPageRelay.asObservable()
    }
}
