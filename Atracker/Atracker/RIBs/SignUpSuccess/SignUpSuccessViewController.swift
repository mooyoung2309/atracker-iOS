//
//  SignUpSuccessViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpSuccessPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SignUpSuccessViewController: UIViewController, SignUpSuccessPresentable, SignUpSuccessViewControllable {

    weak var listener: SignUpSuccessPresentableListener?
}
