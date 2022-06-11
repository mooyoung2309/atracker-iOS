//
//  RIBs+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import UIKit

protocol ContainerViewControllable: ViewControllable {
    var contentView: UIView { get }
    func replace(rib: ViewableRouting)
}

extension ContainerViewControllable {
    
    func replace(rib: ViewableRouting) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        let vc = rib.viewControllable.uiviewController
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
    }
    
    func replace(viewController: UIViewController) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        let vc = viewController
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
    }
    
}
