//
//  EditApplyStageProgressViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift
import UIKit

protocol EditApplyStageProgressPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func tapBackButton()
}

final class EditApplyStageProgressViewController: BaseNavigationViewController, EditApplyStageProgressPresentable, EditApplyStageProgressViewControllable {
    var thisView: UIView {
        return containerView
    }
    
    weak var listener: EditApplyStageProgressPresentableListener?
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        setNavigaionBarTitle("아직 미정이")
        showNavigationBarBackButton()
        showNavigationBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
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
