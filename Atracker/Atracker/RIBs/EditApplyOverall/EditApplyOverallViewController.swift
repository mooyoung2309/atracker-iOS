//
//  EditApplyOverallViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift
import UIKit

protocol EditApplyOverallPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func tapBackButton()
}

final class EditApplyOverallViewController: BaseNavigationViewController, EditApplyOverallPresentable, EditApplyOverallViewControllable {
    var thisView: UIView {
        return containerView
    }
    
    weak var listener: EditApplyOverallPresentableListener?
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        setNavigaionBarTitle("지원 현황 편집")
        showNavigationBarBackButton()
    }
    
    override func setupBind() {
        super.setupBind()
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
    }
}
