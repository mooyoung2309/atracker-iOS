//
//  AlertView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/17.
//

import UIKit
import SnapKit
import RxSwift

class AlertView: BaseView {
    
    var disposeBag = DisposeBag()
    
    let style: AlertStyle
    let i: Int
    
    let backgroundView  = UIView()
    let contentView     = UIView()
    let circleView      = UIView()
    let imageView       = UIImageView()
    let titleLabel      = UILabel()
    let subTitleLabel   = UILabel()
    let buttonStackView = UIStackView()
    let backButton      = UIButton(type: .system)
    let nextButton      = UIButton(type: .system)
    
    var isAlertBack: ((Bool) -> Void)?
    var isAlertNext: ((Bool) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(style: AlertStyle, i: Int) {
        self.style  = style
        self.i      = i
        
        super.init(frame: .zero)
        setupBind()
    }
    
    override func setupProperty() {
        super.setupProperty()
        backgroundView.backgroundColor = .black
        backgroundView.alpha           = 0.5
        
        contentView.backgroundColor = .backgroundLightGray
        contentView.layer.cornerRadius = 10
        
        circleView.backgroundColor      = .backgroundGray
        circleView.layer.cornerRadius   = 20
        
        imageView.image     = UIImage(named: style.iamgeName)
        imageView.tintColor = .neonGreen
        imageView.sizeToFit()
        
        titleLabel.text             = style.title(i: i).string
        titleLabel.font             = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor        = .white
        titleLabel.attributedText   = style.title(i: i)
        
        subTitleLabel.text          = style.subTitle
        subTitleLabel.font          = .systemFont(ofSize: 14, weight: .regular)
        subTitleLabel.textColor     = .gray3
        
        buttonStackView.spacing = 14
        
        backButton.backgroundColor      = .backgroundGray
        backButton.layer.cornerRadius   = 5
        backButton.setTitleColor(.white, for: .normal)
        
        nextButton.backgroundColor      = .backgroundGray
        nextButton.layer.cornerRadius   = 5
        nextButton.setTitleColor(.white, for: .normal)
        
        for (indx, buttonTitle) in style.buttonTitles.enumerated() {
            if indx == 0 {
                backButton.setTitle(buttonTitle, for: .normal)
                buttonStackView.addArrangedSubview(backButton)
                
            } else if indx == 1 {
                nextButton.setTitle(buttonTitle, for: .normal)
                buttonStackView.addArrangedSubview(nextButton)
            }
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(backgroundView)
        addSubview(contentView)
        
        contentView.addSubview(circleView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(buttonStackView)
        
        circleView.addSubview(imageView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
        circleView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(circleView.snp.bottom).inset(-20)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).inset(-20)
            $0.bottom.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(36)
        }
        
        nextButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(36)
        }
    }
    
    func setupBind() {
        backButton.rx.tap
            .bind { [weak self] _ in
                self?.isAlertBack?(true)
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] _ in
                self?.isAlertNext?(true)
            }
            .disposed(by: disposeBag)
    }
    
    func isAlertBack(completion: @escaping (Bool) -> Void) {
        self.isAlertBack = completion
    }
    
    func isAlertNext(completion: @escaping (Bool) -> Void) {
        self.isAlertNext = completion
    }
}
