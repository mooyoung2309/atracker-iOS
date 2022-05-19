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
    
    var typeLabel = UILabel().then {
        $0.textColor = Const.Color.black
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    var contextLabel = UILabel().then {
        $0.textColor = Const.Color.darkGray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.numberOfLines = 10
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
        addSubview(typeLabel)
        addSubview(contextLabel)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        contextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            contextLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            contextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
