//
//  AgreementLineView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import UIKit

class AgreementView: BaseView {
    let leadingButton = UIButton(type: .custom)
    let trailingButton = UIButton(type: .custom)
    let divider = Divider(.white)
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(ageementType: AgreementType) {
        leadingButton.setTitle("   " + ageementType.title, for: .normal)
        if let url = ageementType.url {
            
        } else {
            trailingButton.isHidden = true
        }
        divider.update(ageementType.dividerColor)
        leadingButton.titleLabel?.font = ageementType.titleFont
        super.init(frame: .zero)
    }
    
    override func setupProperty() {
        super.setupProperty()
        leadingButton.setImage(UIImage(named: ImageName.unCheckedCircle), for: .normal)
        leadingButton.setImage(UIImage(named: ImageName.checkedCircle), for: .selected)
        trailingButton.setImage(UIImage(named: ImageName.chevronRight), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        addSubview(leadingButton)
        addSubview(trailingButton)
        addSubview(divider)
    }
    
    override func setupLayout() {
        super.setupLayout()
        leadingButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(28)
        }
        trailingButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(28)
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(leadingButton.snp.bottom).inset(-15)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
