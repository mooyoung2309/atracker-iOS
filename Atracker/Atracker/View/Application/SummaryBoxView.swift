//
//  SummaryBoxView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/23.
//

import UIKit
import Then
class SummaryBoxView: UIView {
    let circleView = UIView().then {
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 4.5
    }
    let titleLabel = UILabel().then {
        $0.text = "서류"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor.init(hex: 0x949494)
    }
    let contentLabel = UILabel().then {
        $0.text = "\(Int.random(in: 10...99)).\(Int.random(in: 0..<10))"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    init(title: String, content: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        contentLabel.text = content
        setView()
    }
}

extension SummaryBoxView {
    func setView() {
        addSubview(circleView)
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            circleView.heightAnchor.constraint(equalToConstant: 9),
            circleView.widthAnchor.constraint(equalToConstant: 9),
            
            titleLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: -10),
            
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
