//
//  ContentSerialization.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation

// MARK: - Content (OVERALL, QNA, FREE)
typealias OVERALLContent = String

struct QNAContent: Codable {
    let a, q, f: String
}

struct FreeContent: Codable {
    let t, b: String
}

class ContentSerialization {
    static let shared = ContentSerialization()
    
    func toOVERALLContent(string: String?) -> OVERALLContent {
        guard let string = string else { return OVERALLContent() }
        
        return string
    }
    
    func toQNAContent(string: String?) -> QNAContent {
        guard let string = string else { return QNAContent(a: "", q: "", f: "") }

        do {
            guard let dict = try JSONSerialization.jsonObject(with: Data(string.utf8), options: []) as? Dictionary<String, Any> else { return QNAContent(a: "", q: "", f: "") }
            let data = try JSONSerialization.data(withJSONObject: dict)
            let questionContent = try JSONDecoder().decode(QNAContent.self, from: data)
            Log("[D] 직렬화 성공 string -> questionContent")
            return questionContent
        } catch {
            Log("[D] 직렬화 실패")
        }
        
        return QNAContent(a: "", q: "", f: "")
    }
    
    func toFreeContent(string: String?) -> FreeContent {
        guard let string = string else { return FreeContent(t: "", b: "") }

        do {
            guard let dict = try JSONSerialization.jsonObject(with: Data(string.utf8), options: []) as? Dictionary<String, Any> else { return FreeContent(t: "", b: "") }
            let data = try JSONSerialization.data(withJSONObject: dict)
            let freeContent = try JSONDecoder().decode(FreeContent.self, from: data)
            Log("[D] 직렬화 성공 string -> questionContent")
            return freeContent
        } catch {
            Log("[D] 직렬화 실패")
        }
        
        return FreeContent(t: "", b: "")
    }
    
    func toOVERALLString(overallContent: OVERALLContent) -> String {
        return overallContent
    }
    
    func toQNAString(qnaContent: QNAContent) -> String {
        do {
            let data = try JSONEncoder().encode(qnaContent)
            guard let string = String(data: data, encoding: String.Encoding.utf8) else { return "" }
            Log("[D] 역직렬화 성공 QNAContent -> String")
            return string
        } catch {
            Log("[D] 역직렬화 실패")
        }
        return ""
    }
    
    func toFreeString(freeContent: FreeContent) -> String {
        do {
            let data = try JSONEncoder().encode(freeContent)
            guard let string = String(data: data, encoding: String.Encoding.utf8) else { return "" }
            Log("[D] 역직렬화 성공 QNAContent -> String")
            return string
        } catch {
            Log("[D] 역직렬화 실패")
        }
        return ""
    }
}
