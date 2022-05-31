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
    
    var titleImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star")
    }
    var titleLabel = UILabel().then {
        $0.text = ""
    }
    var subTitleLabel = UILabel().then {
        $0.text = ""
    }
    var buttonStackView = UIStackView().then {
        $0.spacing = 14
    }
    
    var titleImage: UIImage?
    var defaultTitle: String?
    var highlightTitle: String?
    var subTitle: String?
    var buttonTitles: [String]!
    var buttons: [UIButton] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(titleImage: UIImage?, defaultTitle: String? = nil, highlightTitle: String? = nil, subTitle: String? = nil, buttonTitles: [String]) {
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
        view.backgroundColor = .white
        
        titleImageView.image = titleImage
        titleLabel.text = defaultTitle
//        titleLabel.text = highlightTitle
        subTitleLabel.text = subTitle
        
        for buttonTitle in buttonTitles {
            let button = FixSizedRoundButton(size: CGSize(width: 120, height: 36), title: buttonTitle, backgroundColor: .backgroundGray, tintColor: .white, selectedColor: .red)
            buttons.append(button)
        }
        
        buttonStackView.addArrangedSubviews(buttons)
    }
    
    override func setupHierarchy() {
        view.addSubview(titleImageView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(buttonStackView)
    }
    
    override func setupLayout() {
        titleImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
