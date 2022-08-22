//
//  ResultTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/22.
//

import UIKit
import ReactorKit

class ResultTableViewCell: BaseTVC, View {
    typealias Reactor = ResultTableViewCellReator
    
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
        reactor.state.map(\.title)
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
