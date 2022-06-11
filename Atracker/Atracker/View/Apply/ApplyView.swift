//
//  ApplyView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/01.
//

import UIKit

class ApplyView: BaseView {
    var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    var positionLabel = UILabel().then {
        $0.text = "신입 iOS 개발자"
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray1
    }
    var titleLabel = UILabel().then {
        $0.text = "이소진님의\n지원현황입니다!"
        $0.font = .systemFont(ofSize: 28, weight: .regular)
        $0.textColor = .white
        $0.numberOfLines = 2
    }
    var summaryView = ApplySummaryView()
    var tableView = UITableView().then {
        $0.register(ApplyProgressTVC.self, forCellReuseIdentifier: ApplyProgressTVC.id)
        $0.isScrollEnabled = false
        $0.backgroundColor = .backgroundLightGray
        $0.separatorStyle = .singleLine
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorColor = UIColor(hex: 0x292C3F)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0
        $0.layer.borderColor = UIColor.backgroundLightGray.cgColor
    }
    let myPageButton = UIButton().then {
        $0.setImage(UIImage(named: ImageName.user), for: .normal)
    }
    let notificationButton = UIButton().then {
        $0.setImage(UIImage(named: ImageName.notification), for: .normal)
    }
    let plusButton = UIButton().then {
        $0.backgroundColor = .gray7
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .neonGreen
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 3, height: 3)
        $0.layer.shadowRadius = 3
        $0.layer.cornerRadius = 20
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        let titleAttributeString = NSMutableAttributedString(string: "이소진님의\n지원현황입니다!")
        titleAttributeString.addAttribute(.foregroundColor, value: UIColor.neonGreen, range: ("이소진님의\n지원현황입니다!" as NSString).range(of: "이소진"))
        titleAttributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 28, weight: .bold), range: ("이소진님의\n지원현황입니다!" as NSString).range(of: "이소진"))
        titleLabel.attributedText = titleAttributeString
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        addSubview(scrollView)
        addSubview(plusButton)
        scrollView.addSubview(positionLabel)
        scrollView.addSubview(notificationButton)
        scrollView.addSubview(myPageButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(summaryView)
        scrollView.addSubview(tableView)
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
        summaryView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-20)
            $0.leading.trailing.equalTo(self).inset(16)
            $0.height.equalTo(90)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(summaryView.snp.bottom).inset(-18)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(0)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
    }
}
