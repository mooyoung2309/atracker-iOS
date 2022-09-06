//
//  CompanySearchTableViewCell.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/06.
//

import UIKit
import ReactorKit

class CompanySearchTableViewCell: BaseTVC, View {
    typealias Reactor = CompanySearchTableViewCellReactor
    
    // MARK: - UI Components
    
    let titleLabel: UILabel = .init()
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .light)
        titleLabel.textColor = .white
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(6)
        }
    }
    
    func bind(reactor: Reactor) {
        // State
        if let name = reactor.currentState?.name {
            titleLabel.text = name
        } else {
            titleLabel.text = "+직접추가"
        }
    }
}
