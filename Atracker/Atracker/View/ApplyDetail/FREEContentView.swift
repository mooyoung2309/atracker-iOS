//
//  FREEContentView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/15.
//

import UIKit

class FREEContentView: BaseView {
    
    let titleLabel = UILabel()
    let contextLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(freeContent: FreeContent) {
        super.init(frame: .zero)
        
        titleLabel.text = freeContent.t
        contextLabel.text = freeContent.b
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .neonGreen
        titleLabel.numberOfLines = 0
        
        contextLabel.font = .systemFont(ofSize: 16, weight: .regular)
        contextLabel.textColor = .white
        contextLabel.numberOfLines = 0
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(contextLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        contextLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
