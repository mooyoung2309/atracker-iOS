//
//  CalendarCollectionViewCell.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit
import Then

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalendarCollectionViewCell"
    
    var circleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.alignment = .center
    }
    var buyCircleView = UIView() .then {
        $0.backgroundColor = Const.Color.pink
        $0.layer.cornerRadius = 3
    }
    var sellCircleView = UIView().then {
        $0.backgroundColor = Const.Color.mint
        $0.layer.cornerRadius = 3
    }
    var memoCirlceView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 3
    }
    var divider = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let dateFormatter = DateFormatter()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    override func prepareForReuse() {
        circleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func update(date: Int) {
        dateLabel.text = String(date)
    }
}

extension CalendarCollectionViewCell {
    func setView() {
        backgroundColor = Const.Color.white
        
        addSubview(divider)
        addSubview(dateLabel)
        addSubview(circleStackView)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        circleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: topAnchor),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.18),
            
            dateLabel.topAnchor.constraint(equalTo: divider.bottomAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            circleStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            circleStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleStackView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
}
