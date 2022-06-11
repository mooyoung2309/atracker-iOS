//
//  ApplyDetailViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift
import UIKit

protocol ApplyDetailPresentableListener: AnyObject {
    func setNavigaionTitle()
    func didBackButton()
}

final class ApplyDetailViewController: BaseNavigationViewController, ApplyDetailPresentable, ApplyDetailViewControllable {

    weak var listener: ApplyDetailPresentableListener?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNavigaionBar()
        showNavigaionBar(true)
        showBackButton(true)
    }
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupBind() {
        super.setupBind()
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.didBackButton()
            }
            .disposed(by: disposeBag)
    }
}
