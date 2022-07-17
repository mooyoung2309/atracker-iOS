//
//  ApplyView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/01.
//

import UIKit

class ApplyView: BaseView {
    
    let scrollView = UIScrollView()
    let positionLabel = UILabel()
    let titleLabel = UILabel()
    let analysisView = ApplyAnalysisView()
    let applyTableView = UITableView()
    let myPageButton = UIButton()
    let notificationButton = UIButton()
    let plusButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        let titleAttributeString = NSMutableAttributedString(string: "이소진님의\n지원현황입니다!")
        titleAttributeString.addAttribute(.foregroundColor, value: UIColor.neonGreen, range: ("이소진님의\n지원현황입니다!" as NSString).range(of: "이소진"))
        titleAttributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 28, weight: .bold), range: ("이소진님의\n지원현황입니다!" as NSString).range(of: "이소진"))
        titleLabel.attributedText = titleAttributeString
        
        scrollView.showsVerticalScrollIndicator = false
        
        positionLabel.text = "신입 iOS 개발자"
        positionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        positionLabel.textColor = .gray1
        
        titleLabel.text = "이소진님의\n지원현황입니다!"
        titleLabel.font = .systemFont(ofSize: 28, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        analysisView.backgroundColor = .backgroundLightGray
        analysisView.layer.cornerRadius = 10
        analysisView.update(data: [10, 20, 30, 40])
        
        applyTableView.register(ApplyTVC.self, forCellReuseIdentifier: ApplyTVC.id)
        applyTableView.isScrollEnabled = false
        applyTableView.backgroundColor = .backgroundLightGray
        applyTableView.separatorStyle = .singleLine
        applyTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        applyTableView.separatorColor = UIColor(hex: 0x292C3F)
        applyTableView.rowHeight = UITableView.automaticDimension
        applyTableView.estimatedRowHeight = 100
        applyTableView.layer.masksToBounds = true
        applyTableView.layer.cornerRadius = 12
        applyTableView.layer.borderWidth = 0
        applyTableView.layer.borderColor = UIColor.backgroundLightGray.cgColor
        
        myPageButton.setImage(UIImage(named: ImageName.user), for: .normal)
        
        notificationButton.setImage(UIImage(named: ImageName.notification), for: .normal)
        
        plusButton.backgroundColor = .gray7
        plusButton.contentHorizontalAlignment = .fill
        plusButton.contentVerticalAlignment = .fill
        plusButton.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        plusButton.tintColor = .neonGreen
        plusButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        plusButton.layer.shadowColor = UIColor.black.cgColor
        plusButton.layer.shadowOpacity = 0.3
        plusButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        plusButton.layer.shadowRadius = 3
        plusButton.layer.cornerRadius = 20
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(scrollView)
        addSubview(plusButton)
        
        scrollView.addSubview(positionLabel)
        scrollView.addSubview(notificationButton)
        scrollView.addSubview(myPageButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(analysisView)
        scrollView.addSubview(applyTableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        plusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(36)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.height.equalTo(40)
        }
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        positionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(28)
        }
        notificationButton.snp.makeConstraints {
            $0.centerY.equalTo(positionLabel)
            $0.trailing.equalToSuperview().inset(28)
            $0.width.height.equalTo(24)
        }
        myPageButton.snp.makeConstraints {
            $0.centerY.equalTo(positionLabel)
            $0.trailing.equalTo(notificationButton.snp.leading).inset(-10)
            $0.width.height.equalTo(24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(positionLabel.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(28)
        }
        analysisView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-20)
            $0.leading.trailing.equalTo(self).inset(16)
            $0.height.equalTo(90)
        }
        applyTableView.snp.makeConstraints {
            $0.top.equalTo(analysisView.snp.bottom).inset(-18)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(0)
            $0.bottom.equalToSuperview()
        }
    }
}
