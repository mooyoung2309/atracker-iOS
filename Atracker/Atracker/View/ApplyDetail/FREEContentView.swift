//
//  FREEContentView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/15.
//

import UIKit

class FREEContentView: BaseView {
    
    let contentLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(freeContent: FreeContent) {
        super.init(frame: .zero)
        contentLabel.text = freeContent.t
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentLabel.font = .systemFont(ofSize: 16, weight: .regular)
        contentLabel.textColor = .white
        contentLabel.numberOfLines = 0
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(contentLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentLabel.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
