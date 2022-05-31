//
//  BaseAlertViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/29.
//

import UIKit
import SnapKit
import Then

class AlertViewController: BaseVC {
    
    var contentView = UIView().then {
        $0.backgroundColor = .backgroundLightGray
        $0.layer.cornerRadius = 10
    }
    var titleImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star")
    }
    var titleLabel = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .white
    }
    var subTitleLabel = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .gray3
    }
    var buttonStackView = UIStackView().then {
        $0.spacing = 14
    }
    
    var isBack: ((Bool) -> Void)?
    var isOk: ((Bool) -> Void)?
    
    var titleImage: UIImage?
    var defaultTitle: String!
    var highlightTitle: String!
    var subTitle: String!
    var buttonTitles: [String]!
    var buttons: [UIButton] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(titleImage: UIImage?, defaultTitle: String = "", highlightTitle: String = "", subTitle: String = "", buttonTitles: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.titleImage = titleImage
        self.defaultTitle = defaultTitle
        self.highlightTitle = highlightTitle
        self.subTitle = subTitle
        self.buttonTitles = buttonTitles
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        view.backgroundColor = UIColor(hex: 0x000000, alpha: 0.8)
        
        titleImageView.image = titleImage
        titleLabel.text = defaultTitle
//        titleLabel.text = highlightTitle
        subTitleLabel.text = subTitle
        
        let titleAttributeString = NSMutableAttributedString(string: defaultTitle)
        titleAttributeString.addAttribute(.foregroundColor, value: UIColor.neonGreen, range: (defaultTitle  as NSString).range(of: highlightTitle))
        titleAttributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .bold), range: (defaultTitle  as NSString).range(of: highlightTitle))
        titleLabel.attributedText = titleAttributeString
        
        for buttonTitle in buttonTitles {
            let button = FixSizedRoundButton(size: CGSize(width: 120, height: 36), round: 5, title: buttonTitle, backgroundColor: .backgroundGray, tintColor: .white, selectedColor: .red)
            buttons.append(button)
        }
        
        buttonStackView.addArrangedSubviews(buttons)
    }
    
    override func setupHierarchy() {
        view.addSubview(contentView)
        contentView.addSubview(titleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(buttonStackView)
    }
    
    override func setupLayout() {
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
        titleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).inset(-20)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).inset(-20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        for (index, button) in buttons.enumerated() {
            if index == 0 {
                button.rx.tap
                    .withUnretained(self)
                    .bind { owner, _ in
                        owner.isBack?(true)
                    }
                    .disposed(by: disposeBag)
            } else if index == 1 {
                button.rx.tap
                    .withUnretained(self)
                    .bind { owner, _ in
                        owner.isOk?(true)
                    }
                    .disposed(by: disposeBag)
            }
            
        }
    }
    
    func isBack(completion: @escaping (Bool) -> Void) {
        self.isBack = completion
    }
    
    func isOk(completion: @escaping (Bool) -> Void) {
        self.isOk = completion
    }
}
