//
//  StageRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/31.
//

import Alamofire
import RxSwift

protocol StageRepositable {
    func get() -> Observable<StageResponse>
    func post(request: StageCreateRequest) -> Observable<StageCreateResponse>
}

class StageRepository: Repository, StageRepositable {
    func get() -> Observable<StageResponse> {
        return send(api: StageAPI.get)
    }
    
    func post(request: StageCreateRequest) -> Observable<StageCreateResponse> {
        return send(api: StageAPI.post(request))
    }
}
