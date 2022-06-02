//
//  CalendarCollectionViewCell.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit
import SnapKit
import Then

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalendarCollectionViewCell"
    
    var circleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.distribution = .fillProportionally
    }
    var circleView1 = CircleView(color: .blue5)
    var circleView2 = CircleView(color: .neonGreen)
    var lineView = UIView().then {
        $0.backgroundColor = .neonGreen
    }
    var lineBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.05
    }
    
    var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let dateFormatter = DateFormatter()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    override func prepareForReuse() {
        circleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func update(date: Int) {
        dateLabel.text = String(date)
    }
    
    func showCircle(_ bool: Bool) {
        if bool {
            circleStackView.isHidden = false
        } else {
            circleStackView.isHidden = true
        }
    }
    
    func showLine(_ bool: Bool, edge: UIRectEdge? = nil) {
        if bool {
            lineView.isHidden = false
        } else {
            lineView.isHidden = true
        }
        guard let edge = edge else { return }
        
        switch edge {
        case .left:
            lineView.clipsToBounds = true
            lineView.layer.cornerRadius = 2
            lineView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            return
        case .right:
            lineView.clipsToBounds = true
            lineView.layer.cornerRadius = 2
            lineView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            return
        default:
            return
        }
    }
    
    func showLineBackground(_ bool: Bool, edge: UIRectEdge? = nil) {
        if bool {
            lineBackgroundView.isHidden = false
        } else {
            lineBackgroundView.isHidden = true
        }
        guard let edge = edge else { return }
        
        switch edge {
        case .left:
            lineBackgroundView.clipsToBounds = true
            lineBackgroundView.layer.cornerRadius = 15
            lineBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            return
        case .right:
            lineBackgroundView.clipsToBounds = true
            lineBackgroundView.layer.cornerRadius = 15
            lineBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            return
        default:
            return
        }
    }
}

extension CalendarCollectionViewCell {
    func setupProperty() {
        backgroundColor = .clear
        
        circleStackView.addArrangedSubviews([circleView1, circleView2])
    }
    
    func setupHierarchy() {
        contentView.addSubview(lineBackgroundView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(circleStackView)
        contentView.addSubview(lineView)
    }
    
    func setupLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
        }
        
        circleStackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(4)
        }
        
        lineBackgroundView.snp.makeConstraints {
            $0.top.bottom.equalTo(dateLabel).inset(-5)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
