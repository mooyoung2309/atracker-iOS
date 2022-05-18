//
//  SummaryApplicationStatusView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit

class SummaryApplicationView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setView()
    }
}

extension SummaryApplicationView {
    func setView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
