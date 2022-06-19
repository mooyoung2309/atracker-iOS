//
//  ApplyWriteViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol ApplyWritePresentableListener: AnyObject {
    func tapBackButton()
}

final class ApplyWriteViewController: BaseNavigationViewController, ApplyWritePresentable, ApplyWriteViewControllable {
    var contentView: UIView {
        return mainView
    }
    weak var listener: ApplyWritePresentableListener?
    
    let selfView = ApplyWriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigaionBar(true)
        showNavigaionBarBackButton(true)
        setNavigaionBarTitle("지원 현황 추가")
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
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
    }
}
