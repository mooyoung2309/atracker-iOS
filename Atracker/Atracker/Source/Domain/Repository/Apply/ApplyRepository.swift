//
//  ApplyRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/31.
//

import Alamofire
import RxSwift

protocol ApplyRepositable {
    func get(request: ApplyRequest) -> Observable<ApplyResponse>
    func post(request: ApplyCreateRequest) -> Observable<VoidModel>
    func put(request: ApplyUpdateRequest) -> Observable<VoidModel>
    func delete(request: ApplyDeleteRequest) -> Observable<VoidModel>
}

class ApplyRepository: Repository, ApplyRepositable {
    func get(request: ApplyRequest) -> Observable<ApplyResponse> {
        return send(api: ApplyAPI.get(request))
    }
    
    func post(request: ApplyCreateRequest) -> Observable<VoidModel> {
        return send(api: ApplyAPI.post(request))
    }
    
    func put(request: ApplyUpdateRequest) -> Observable<VoidModel> {
        return send(api: ApplyAPI.put(request))
    }
    
    func delete(request: ApplyDeleteRequest) -> Observable<VoidModel> {
        return send(api: ApplyAPI.delete(request))
    }
}

