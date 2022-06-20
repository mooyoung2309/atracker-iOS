//
//  RIBs+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import UIKit
import SnapKit

protocol NavigationContainerViewControllable: ViewControllable {
    var thisView: UIView { get }
    var mainView: UIView { get }
    func replace(viewController: UIViewController, transitionSubType: CATransitionSubtype?)
    func dismiss()
}

extension NavigationContainerViewControllable {
    func dismiss() {
        thisView.subviews.forEach { $0.removeFromSuperview() }
        mainView.frame = thisView.bounds
        thisView.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func replace(viewController: UIViewController, transitionSubType: CATransitionSubtype? = nil) {
        thisView.subviews.forEach { $0.removeFromSuperview() }
        let vc = viewController
        vc.view.frame = thisView.bounds
        
        if let transitionSubType = transitionSubType {
            let transition = CATransition()
            transition.type = .push
            transition.subtype = transitionSubType
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            transition.duration = 0.25
            thisView.layer.add(transition, forKey: nil)
            thisView.addSubview(vc.view)
        } else {
            thisView.addSubview(vc.view)
        }
    }
}

protocol ContainerViewControllable: ViewControllable {
    var thisView: UIView { get }
    func replace(rib: ViewableRouting)
}

extension ContainerViewControllable {
    
    
    func replace(rib: ViewableRouting) {
        thisView.subviews.forEach { $0.removeFromSuperview() }
        let vc = rib.viewControllable.uiviewController
        vc.view.frame = thisView.bounds
    }
    
    func replaceFull(viewController: UIViewController, transitionSubType: CATransitionSubtype? = nil) {
        uiviewController.view.addSubview(viewController.view)
//        uiviewController.present(viewController, animated: true, completion: nil)
    }
    
    func replace(viewController: UIViewController, transitionSubType: CATransitionSubtype? = nil) {
        thisView.subviews.forEach { $0.removeFromSuperview() }
        let vc = viewController
        vc.view.frame = thisView.bounds
        
        if let transitionSubType = transitionSubType {
            let transition = CATransition()
            transition.type = .push
            transition.subtype = transitionSubType
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            transition.duration = 0.25
            thisView.layer.add(transition, forKey: nil)
            thisView.addSubview(vc.view)
        } else {
            thisView.addSubview(vc.view)
        }
    }
}
