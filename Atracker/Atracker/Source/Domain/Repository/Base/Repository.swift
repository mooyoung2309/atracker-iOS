//
//  Repository.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/31.
//

import Alamofire
import RxSwift

protocol Repository {
    func send<T: Codable>(api: API) -> Observable<T>
    func sendWithNoToken<T: Codable>(api: API) -> Observable<T>
}

extension Repository {
    func send<T: Codable>(api: API) -> Observable<T> {
        return Observable<T>.create { observer in
            AF.request(api, interceptor: TokenInterceptor.shared.getInterceptor()).responseDecodable { (response: AFDataResponse<T>) in
                print(response.data)
                print(response.response)
                print(response.result)
                print(response.error)
                print(response.request)
                print(response.debugDescription)
                print(response.description)
                print(response.value)
                switch response.result {
                case let .success(data):
                    observer.onNext(data)
                case let .failure(error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func sendWithNoToken<T: Codable>(api: API) -> Observable<T> {
        return Observable<T>.create { observer in
            AF.request(api).responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case let .success(data):
                    observer.onNext(data)
                case let .failure(error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
