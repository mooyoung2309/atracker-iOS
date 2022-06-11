//
//  PlanViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import RxSwift
import UIKit

protocol PlanPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PlanViewController: BaseViewController, PlanPresentable, PlanViewControllable {

    weak var listener: PlanPresentableListener?
    
    override func setupProperty() {
        super.setupProperty()
        
        self.view.backgroundColor = .red
        self.preferredContentSize = CGSize(width: 100, height: 100)
    }
}
