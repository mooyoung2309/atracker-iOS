//
//  UIViewController+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/28.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    public var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
           .map { $0.first as? Bool ?? false }
      }
}
