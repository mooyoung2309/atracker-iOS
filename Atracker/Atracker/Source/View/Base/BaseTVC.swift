//
//  BaseTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/01.
//

import UIKit
import SnapKit
import Then
import RxSwift

class BaseTVC: UITableViewCell {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Setup Methods
    
    func setupProperty() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
    
    func setupBind() { }
}
