//
//  BaseURLRequestConvertible.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation
import Alamofire

protocol BaseURLRequestConvertible: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams? { get }
}

extension BaseURLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var urlRequest = try URLRequest(url: path, method: method)
        urlRequest.setValue(ContentType.json.code, forHTTPHeaderField: HTTPHeaderField.contentType.code)
        
        switch parameters {
        case .query(let request):
            let params = request?.toDictionary() ?? [:]
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: path)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .body(let request):
            if let request = request {
                let data = try JSONEncoder().encode(AnyEncodable(request))
                urlRequest.httpBody = data
            }
        case .both(let queryRequest, let bodyRequest):
            let queryDict = queryRequest?.toDictionary() ?? [:]
            let queryParams = queryDict.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: path)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
            let bodyDict = bodyRequest?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyDict, options: [])
        default:
            print("param is nil")
        }
        return urlRequest
    }
}

enum RequestParams {
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
    case both(_ queryParameter: Encodable?, _ bodyParameter: Encodable?)
}
