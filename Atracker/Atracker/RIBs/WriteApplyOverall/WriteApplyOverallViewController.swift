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

protocol WriteApplyOverallPresentableListener: AnyObject {
    func tapBackButton()
    func tapNextButton()
}

final class WriteApplyOverallViewController: BaseNavigationViewController, WriteApplyOverallPresentable, WriteApplyOverallViewControllable {
    
    var thisView: UIView {
        return containerView
    }
    
    weak var listener: WriteApplyOverallPresentableListener?
    
    let selfView = ApplyWriteView()
    
    func showNavigationBar() {
        showNavigaionBar(true)
        showNavigaionBarBackButton(true)
        setNavigaionBarTitle("지원 현황 추가")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
    }
    
    override func setupProperty() {
        super.setupProperty()

    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(selfView)
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
        
        selfView.nextButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapNextButton()
            }
            .disposed(by: disposeBag)
    }
}
