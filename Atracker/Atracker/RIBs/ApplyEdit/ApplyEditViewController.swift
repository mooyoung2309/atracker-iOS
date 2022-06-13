//
//  ApplyEditViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol ApplyEditPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func didTapBackButton()
}

final class ApplyEditViewController: BaseNavigationViewController, ApplyEditPresentable, ApplyEditViewControllable {

    weak var listener: ApplyEditPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigaionBar(true)
        showNavigaionBarBackButton(true)
        showNavigaionBarTrailingButton(true)
    }
    
    override func setupBind() {
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.didTapBackButton()
            }
            .disposed(by: disposeBag)
    }
}
