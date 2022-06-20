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
    func pushView(_ viewController: UIViewController, animation: Bool, transitionSubType: CATransitionSubtype?)
    func pushView(_ rib: ViewableRouting, animation: Bool, transitionSubType: CATransitionSubtype?)
    func pushView(_ viewcontrollable: ViewControllable, animation: Bool, transitionSubType: CATransitionSubtype?)
    func popView(animation: Bool, transitionSubType: CATransitionSubtype?)
}

extension NavigationContainerViewControllable {
    func pushView(_ viewController: UIViewController, animation: Bool = true, transitionSubType: CATransitionSubtype? = .fromRight) {
        thisView.subviews.forEach { $0.removeFromSuperview() }
        let vc = viewController
        vc.view.frame = thisView.bounds
        
        if animation {
            let transition = CATransition()
            transition.type = .push
            transition.subtype = transitionSubType
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            transition.duration = 0.25
            thisView.layer.add(transition, forKey: nil)
        }
        
        thisView.addSubview(vc.view)
    }
    
    func pushView(_ rib: ViewableRouting, animation: Bool = true, transitionSubType: CATransitionSubtype? = .fromRight) {
        self.pushView(rib.viewControllable.uiviewController, animation: animation, transitionSubType: transitionSubType)
    }
    
    func pushView(_ viewcontrollable: ViewControllable, animation: Bool = true, transitionSubType: CATransitionSubtype? = .fromRight) {
        self.pushView(viewcontrollable.uiviewController, animation: animation, transitionSubType: transitionSubType)
    }
    
    func popView(animation: Bool = true, transitionSubType: CATransitionSubtype? = .fromLeft) {
        thisView.subviews.forEach { $0.removeFromSuperview() }
        mainView.frame = thisView.bounds
        
        if animation {
            let transition = CATransition()
            transition.type = .push
            transition.subtype = transitionSubType
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            transition.duration = 0.25
            thisView.layer.add(transition, forKey: nil)
        }
        
        thisView.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ViewableRouter {
    func detachChildRIB(_ child: Routing?) {
        guard let child = child else { return }
        detachChild(child)
    }
}
