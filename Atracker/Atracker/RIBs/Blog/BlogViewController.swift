//
//  BlogViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import RxSwift
import UIKit

protocol BlogPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BlogViewController: BaseViewController, BlogPresentable, BlogViewControllable {

    weak var listener: BlogPresentableListener?
    
    override func setupProperty() {
        super.setupProperty()
        
        self.view.backgroundColor = .white
        self.preferredContentSize = CGSize(width: 100, height: 100)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    }
    
    override func setupLayout() {
        super.setupLayout()
    }
}
