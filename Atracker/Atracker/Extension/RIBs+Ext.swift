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
        
        
    }
    
    func replace(viewController: UIViewController, transitionSubType: CATransitionSubtype? = nil) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        let vc = viewController
        vc.view.frame = contentView.bounds
        
        if let transitionSubType = transitionSubType {
            let transition = CATransition()
            transition.type = .push
            transition.subtype = transitionSubType
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            transition.duration = 0.25
            contentView.layer.add(transition, forKey: nil)
            contentView.addSubview(vc.view)
        } else {
            contentView.addSubview(vc.view)
        }
    }
}
