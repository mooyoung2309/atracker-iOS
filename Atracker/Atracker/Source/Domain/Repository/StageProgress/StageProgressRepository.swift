//
//  StageProgressRepository.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/31.
//

import Alamofire
import RxSwift

protocol StageProgressRepositable {
    func put(request: StageProgressUpdateRequest) -> Observable<VoidModel>
}

class StageProgressRepository: Repository, StageProgressRepositable{
    func put(request: StageProgressUpdateRequest) -> Observable<VoidModel> {
        return send(api: StageProgressAPI.put(request))
    }
}
