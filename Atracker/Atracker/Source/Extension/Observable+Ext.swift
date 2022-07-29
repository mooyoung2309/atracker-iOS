//
//  Observable+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/28.
//

import Foundation
import RxSwift

extension Observable {
  func mapVoid() -> Observable<Void> {
    return map { _ in Void() }
  }
}
