//
//  StageProgressService.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/01.
//

import Alamofire
import RxSwift

protocol StageProgressServicable {
    func put(request: StageProgressUpdateRequest) -> Observable<VoidModel>
}

class StageProgressService: StageProgressServicable {
    let repository: StageProgressRepository = .init()
    
    func put(request: StageProgressUpdateRequest) -> Observable<VoidModel> {
        return repository.put(request: request)
    }
}
