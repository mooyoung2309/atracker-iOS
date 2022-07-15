//
//  StatusEditBarView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class StageStatusButton: UIButton {
    let color: UIColor
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(color: UIColor) {
        self.color = color
        
        super.init(frame: .zero)
        
        backgroundColor = .backgroundLightGray
        
        setTitleColor(.gray3, for: .normal)
        setTitleColor(color, for: .selected)
        
        titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = 12
    }
    
    override var isSelected: Bool {
        didSet(oldValue) {
            if self.isSelected {
                self.layer.borderColor = color.cgColor
            } else {
                self.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}

class StageStatusButtonBar: BaseView {
    let buttonStackView = UIStackView()
    let notStartedButton = StageStatusButton(color: .white)
    let failButton = StageStatusButton(color: .white)
    let passButton = StageStatusButton(color: .neonGreen)
    let editButton = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        buttonStackView.spacing       = 8
        buttonStackView.distribution  = .fillEqually
        buttonStackView.addArrangedSubviews([notStartedButton, failButton, passButton])
        
        notStartedButton.setTitle(ProgressStatus.notStarted.title, for: .normal)
        
        failButton.setTitle(ProgressStatus.fail.title, for: .normal)
        
        passButton.setTitle(ProgressStatus.pass.title, for: .normal)
        
        editButton.setTitle("편집", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(buttonStackView)
        addSubview(editButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        buttonStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(211)
            $0.height.equalTo(26)
        }
        
        editButton.snp.makeConstraints {
            $0.centerY.equalTo(buttonStackView)
            $0.trailing.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        notStartedButton.rx.tap
            .bind { [weak self] _ in
                self?.clearButtons()
                self?.notStartedButton.isSelected = true
            }
            .disposed(by: disposeBag)
        
        failButton.rx.tap
            .bind { [weak self] _ in
                self?.clearButtons()
                self?.failButton.isSelected = true
            }
            .disposed(by: disposeBag)
        
        passButton.rx.tap
            .bind { [weak self] _ in
                self?.clearButtons()
                self?.passButton.isSelected = true
            }
            .disposed(by: disposeBag)
    }
    
    func clearButtons() {
        notStartedButton.isSelected = false
        failButton.isSelected = false
        passButton.isSelected = false
    }
}
