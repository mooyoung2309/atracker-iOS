//
//  StageService.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/12.
//

import Alamofire
import RxSwift

protocol StageServicable {
    func get() -> Observable<StageResponse>
    func post(request: StageCreateRequest) -> Observable<StageCreateResponse>
}

class StageService: Repository, StageServicable {
    let repository: StageRepository = .init()
    
    func get() -> Observable<StageResponse> {
        return repository.get()
    }
    
    func post(request: StageCreateRequest) -> Observable<StageCreateResponse> {
        return repository.post(request: request)
    }
}
