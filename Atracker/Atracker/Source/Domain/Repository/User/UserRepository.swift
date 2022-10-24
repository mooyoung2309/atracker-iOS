//
//  UserRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/01.
//

import Alamofire
import RxSwift

protocol UserRepositable {
    func myPage() -> Observable<MyPageResponse>
}

class UserRepository: Repository, UserRepositable {
    func myPage() -> Observable<MyPageResponse> {
        return send(api: UserAPI.myPage)
    }
}
