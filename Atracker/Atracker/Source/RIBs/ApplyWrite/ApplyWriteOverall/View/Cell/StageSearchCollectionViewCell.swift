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
    
    let stackView: UIStackView = .init()
    let titleLabel: UILabel = .init()
    let circleView: UIView = .init()
    let circleLabel: UILabel = .init()
    
    // MARK: - Setup Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        stackView.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.backgroundColor = .backgroundLightGray
        stackView.roundCorners(.allCorners, radius: 15)
        stackView.addBorders(for: [.all], width: 1, color: .clear)

        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        circleView.backgroundColor     = .neonGreen
        circleView.roundCorners(.allCorners, radius: 6.5)
        
        circleLabel.textColor = .black
        circleLabel.font = .systemFont(ofSize: 9, weight: .regular)
        circleLabel.textAlignment = .center
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews([titleLabel, circleView])
        circleView.addSubview(circleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        circleView.snp.makeConstraints {
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

