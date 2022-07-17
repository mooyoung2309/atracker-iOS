//
//  Encodable+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
}

extension Encodable {
  fileprivate func encode(to container: inout SingleValueEncodingContainer) throws {
    try container.encode(self)
  }
}

struct AnyEncodable : Encodable {
  var value: Encodable
  init(_ value: Encodable) {
    self.value = value
  }
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try value.encode(to: &container)
  }
}

