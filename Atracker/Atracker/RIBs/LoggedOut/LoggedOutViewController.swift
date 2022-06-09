//
//  LoggedOutViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import Then

protocol LoggedOutPresentableListener: AnyObject {
    func login(withEmail: String?, _ password: String?)
}

final class LoggedOutViewController: BaseVC, LoggedOutPresentable, LoggedOutViewControllable {
    weak var listener: LoggedOutPresentableListener?
    
    let yesButton = UIButton(type: .system).then {
        $0.setTitle("로그인 성공", for: .normal)
    }
    let noButton = UIButton(type: .system).then {
        $0.setTitle("로그인 실패", for: .normal)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .backgroundGray
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(yesButton)
        view.addSubview(noButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        yesButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(100)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        noButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(100)
            $0.width.height.equalTo(100)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        yesButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.login(withEmail: "ddd", "ddd")
            })
            .disposed(by: disposeBag)
    }
}
