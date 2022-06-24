//
//  WriteApplyOverallCVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/21.
//

import UIKit
import SnapKit

class WriteApplyOverallCVC: BaseCVC {
    static let id = "WriteApplyOverallCVC"
    
    let buttonView  = UIView()
    let stackView   = UIStackView()
    let buttonLabel = UILabel()
    let orderCircle  = UIView()
    let orderLabel   = UILabel()
    
    func update(title: String) {
        buttonLabel.text = title
        
        stackView.addArrangedSubview(buttonLabel)
    }
    
    func showHighlight(order: Int) {
        orderLabel.text = "\(order)"
        
        stackView.addArrangedSubview(orderCircle)
        buttonView.layer.borderColor = UIColor.neonGreen.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        buttonView.layer.borderColor    = UIColor.clear.cgColor
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        
        buttonView.backgroundColor      = .backgroundLightGray
        buttonView.layer.cornerRadius   = 15
        buttonView.layer.borderWidth    = 1
        buttonView.layer.borderColor    = UIColor.clear.cgColor
        
        
        buttonLabel.font            = .systemFont(ofSize: 14, weight: .regular)
        buttonLabel.textColor       = .white
        buttonLabel.textAlignment   = .center
        
        orderCircle.backgroundColor     = .neonGreen
        orderCircle.layer.cornerRadius  = 6.5
        
        orderLabel.textColor        = .black
        orderLabel.font             = .systemFont(ofSize: 9, weight: .regular)
        orderLabel.textAlignment    = .center
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(buttonView)
        buttonView.addSubview(stackView)
        orderCircle.addSubview(orderLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        buttonView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        orderCircle.snp.makeConstraints {
            $0.width.height.equalTo(13)
        }
        
        orderLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
