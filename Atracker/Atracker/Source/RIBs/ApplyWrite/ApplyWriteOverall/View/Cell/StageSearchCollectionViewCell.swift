//
//  StageSearchCollectionViewCell.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/07.
//

import UIKit
import ReactorKit

class StageSearchCollectionViewCell: BaseCollectionViewCell, View {
    typealias Reactor = StageSearchCollectionViewCellReactor
    
    // MARK: - UI Components
    
    let titleLabel: UILabel = .init()
    let circleView: UIView = .init()
    let circleLabel: UILabel = .init()
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = .backgroundLightGray
        contentView.setupCornerRadius(15, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])

        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        circleView.backgroundColor = .neonGreen
        circleView.roundCorners(.allCorners, radius: 6.5)
        
        circleLabel.textColor = .black
        circleLabel.font = .systemFont(ofSize: 9, weight: .regular)
        circleLabel.textAlignment = .center
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews(titleLabel, circleView)
        circleView.addSubview(circleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        circleView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.width.height.equalTo(13)
        }
        
        circleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        titleLabel.text = reactor.currentState.stage.title
        
        if let order = reactor.currentState.order {
            circleLabel.text = "\(order + 1)"
        }
    }
}

