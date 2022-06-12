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
    func didBackButton()
}

final class ApplyDetailViewController: BaseNavigationViewController, ApplyDetailPresentable, ApplyDetailViewControllable {
    var contentView: UIView {
        return mainView
    }
    

    weak var listener: ApplyDetailPresentableListener?
    
    let selfView = ApplyDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigaionBar(true)
        showNavigaionBarBackButton(true)
        showNavigaionBarTrailingButton(true)
        setNavigaionBarTrailingButtonTitle("저장")
    }
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        mainContentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
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
