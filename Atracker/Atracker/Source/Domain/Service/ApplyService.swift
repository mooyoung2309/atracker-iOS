//
//  ApplyService.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/01.
//

import Alamofire
import RxSwift

protocol ApplyServicable {
    func get(request: ApplyRequest) -> Observable<ApplyResponse>
    func post(request: ApplyCreateRequest) -> Observable<VoidModel>
    func put(request: ApplyUpdateRequest) -> Observable<VoidModel>
    func delete(request: ApplyDeleteRequest) -> Observable<VoidModel>
}

class ApplyService: ApplyServicable {
    let repository: ApplyRepository = .init()
    
    func get(request: ApplyRequest) -> Observable<ApplyResponse> {
        return repository.get(request: request)
    }
    
    func post(request: ApplyCreateRequest) -> Observable<VoidModel> {
        return repository.post(request: request)
    }
    
    func put(request: ApplyUpdateRequest) -> Observable<VoidModel> {
        return repository.put(request: request)
    }
    
    func delete(request: ApplyDeleteRequest) -> Observable<VoidModel> {
        return repository.delete(request: request)
    }
}
