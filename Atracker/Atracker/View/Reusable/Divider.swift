//
//  Divider.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import Foundation
import UIKit
import SnapKit

class Divider: BaseView {
    
    let contentView = UIView()
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(_ color: UIColor) {
        super.init(frame: .zero)
        contentView.backgroundColor = color
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(contentView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
