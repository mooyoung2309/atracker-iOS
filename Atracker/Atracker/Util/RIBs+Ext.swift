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
//        contentView.addSubview(vc.view)
        
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.duration = 3
       contentView.layer.add(transition, forKey: nil)
       contentView.addSubview(vc.view)
        
//        UIView.transition(with: self.contentView, duration: 0.25, options: [.], animations: {
//            self.contentView.addSubview(vc.view)
//        }, completion: nil)
    }
    
    func replace(viewController: UIViewController) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        let vc = viewController
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
    }
    
}
