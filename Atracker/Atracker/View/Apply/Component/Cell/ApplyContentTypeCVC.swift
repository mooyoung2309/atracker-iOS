//
//  ReviewTypeTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/24.
//

import UIKit
import Then
class ApplyContentTypeCVC: UICollectionViewCell {
    static let id = "ApplyContentTypeCVC"
    
    let titleLabel = UILabel().then {
        $0.text = "서류"
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .white
    }
    let bottomBarView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupProperty()
    }
    
    //    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    //        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    //    }
    
    func update(title: String) {
        titleLabel.text = title
    }
}

extension ApplyContentTypeCVC {
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(bottomBarView)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        bottomBarView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(titleLabel)
        }
    }
    
    func setupProperty() {
        
    }
}
