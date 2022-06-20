//
//  WriteApplyScheduleViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs
import RxSwift
import UIKit

protocol WriteApplySchedulePresentableListener: AnyObject {
    func tapBackButton()
}

final class WriteApplyScheduleViewController: BaseNavigationViewController, WriteApplySchedulePresentable, WriteApplyScheduleViewControllable {

    weak var listener: WriteApplySchedulePresentableListener?
    
    let selfView = ApplyWriteDateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigaionBar(true)
        showNavigaionBarBackButton(true)
        setNavigaionBarTitle("일정 등록")
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
    }
}
