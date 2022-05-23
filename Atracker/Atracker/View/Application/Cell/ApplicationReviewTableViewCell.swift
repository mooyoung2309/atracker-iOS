//
//  ApplicationReviewTableViewCell.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit

class ApplicationReviewTableViewCell: UITableViewCell {
    static let identifier = "ApplicationReviewTableViewCell"
    var type: String!
    var contexts: [String]!
    
    var circleView = UIView().then {
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 4.5
    }
    var typeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    var contextLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    func update(type: String, contexts: [String]) {
        self.type = type
        self.contexts = contexts
        typeLabel.text = type
        contextLabel.text = contexts.first
    }
}

extension ApplicationReviewTableViewCell {
    func setView() {
        backgroundColor = .mainViewColor
        
        addSubview(circleView)
        addSubview(typeLabel)
        addSubview(contextLabel)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        contextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            circleView.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 9),
            circleView.heightAnchor.constraint(equalToConstant: 9),
            
            typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 5),
            
            contextLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 15),
            contextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
