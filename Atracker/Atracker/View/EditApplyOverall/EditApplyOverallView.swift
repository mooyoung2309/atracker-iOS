//
//  EditApplyOverallView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import UIKit

class EditApplyOverallView: BaseView {
    
    let companyLabel = UILabel()
    let companyUnderLineTextFieldView = UnderLineTextFieldView(title: "회사명", placeholder: "회사명을 입력해주세요.")
    let companyTableView = UITableView()
    let positionUnderLineTextFieldView = UnderLineTextFieldView(title: "포지션", placeholder: "포지션명을 입력해주세요.")
    let jobTypeUnderLineLabelView = UnderLineLabelView(title: "근무형태", placeholder: "근무형태를 선택해주세요.")
    let jobTypeTableView = UITableView()
    let stageProgressLabel = UILabel()
    let stageProgressCircleStackView = UIStackView()
    let stageProgressTableView = UITableView()
    let reloadButton = UIButton(type: .custom)
    let nextButton = UIButton(type: .system)
    
    func showStageCircle(max: Int) {
        
        stageProgressCircleStackView.subviews.forEach({ $0.removeFromSuperview() })
        
        for i in 0..<max {
            let circle = UIView()
            let circleLabel = UILabel()
            
            circle.addSubview(circleLabel)
            circle.backgroundColor = .neonGreen
            circle.layer.cornerRadius = 6.5
            
            circleLabel.text = "\(i)"
            circleLabel.textColor = .black
            circleLabel.textAlignment = .center
            circleLabel.font = .systemFont(ofSize: 9, weight: .bold)
            
            circle.snp.makeConstraints {
                $0.width.height.equalTo(13)
            }
            
            circleLabel.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
            
            stageProgressCircleStackView.addArrangedSubview(circle)
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        companyLabel.text = "회사명"
        companyLabel.font = .systemFont(ofSize: 14, weight: .medium)
        companyLabel.textColor = .gray3
        
        companyUnderLineTextFieldView.button.setBackgroundImage(UIImage(named: ImageName.search)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        companyUnderLineTextFieldView.button.setBackgroundImage(UIImage(named: ImageName.cancle)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .selected)
        companyUnderLineTextFieldView.button.isHidden = false
        
        companyTableView.register(SearchTVC.self, forCellReuseIdentifier: SearchTVC.id)
        companyTableView.backgroundColor = .backgroundLightGray
        companyTableView.rowHeight = UITableView.automaticDimension
        companyTableView.estimatedRowHeight = 50
        
        jobTypeUnderLineLabelView.button.setBackgroundImage(UIImage(named: ImageName.checkBottom)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        jobTypeUnderLineLabelView.button.isHidden = false
        
        jobTypeTableView.register(SearchTVC.self, forCellReuseIdentifier: SearchTVC.id)
        jobTypeTableView.backgroundColor = .backgroundLightGray
        jobTypeTableView.rowHeight = 40
//        jobSearchTableView.estimatedRowHeight = 50
        jobTypeTableView.isScrollEnabled = false
        
        stageProgressLabel.text = "드래그해서 지원단계 순서를 변경할 수 있어요."
        stageProgressLabel.font = .systemFont(ofSize: 14, weight: .medium)
        stageProgressLabel.textColor = .gray3
        
        stageProgressCircleStackView.distribution = .equalSpacing
        stageProgressCircleStackView.axis = .vertical
        
        stageProgressTableView.register(DraggableStageTVC.self, forCellReuseIdentifier: DraggableStageTVC.id)
        stageProgressTableView.backgroundColor = .clear
        stageProgressTableView.rowHeight = UITableView.automaticDimension
        stageProgressTableView.estimatedRowHeight = 70
        stageProgressTableView.isScrollEnabled = false
        
        reloadButton.setImage(UIImage(named: ImageName.reload)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        reloadButton.tintColor = .gray6
        
        nextButton.setTitle("완료", for: .normal)
        nextButton.setTitleColor(.neonGreen, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        nextButton.backgroundColor = .backgroundGray
        nextButton.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(companyUnderLineTextFieldView)
        addSubview(positionUnderLineTextFieldView)
        addSubview(jobTypeUnderLineLabelView)
        addSubview(stageProgressLabel)
        addSubview(stageProgressCircleStackView)
        addSubview(stageProgressTableView)
        addSubview(reloadButton)
        addSubview(nextButton)
        addSubview(jobTypeTableView)
        addSubview(companyTableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        companyUnderLineTextFieldView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        companyTableView.snp.makeConstraints {
            $0.top.equalTo(companyUnderLineTextFieldView.snp.bottom)
            $0.leading.trailing.equalTo(companyUnderLineTextFieldView)
            $0.height.equalTo(0)
        }
        
        positionUnderLineTextFieldView.snp.makeConstraints {
            $0.top.equalTo(companyUnderLineTextFieldView.snp.bottom).inset(-34)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        jobTypeUnderLineLabelView.snp.makeConstraints {
            $0.top.equalTo(positionUnderLineTextFieldView.snp.bottom).inset(-39)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        jobTypeTableView.snp.makeConstraints {
            $0.top.equalTo(jobTypeUnderLineLabelView.snp.bottom)
            $0.leading.trailing.equalTo(jobTypeUnderLineLabelView)
            $0.height.equalTo(0)
        }
        
        stageProgressLabel.snp.makeConstraints {
            $0.top.equalTo(jobTypeUnderLineLabelView.snp.bottom).inset(-39)
            $0.leading.equalToSuperview().inset(28)
        }
        
        stageProgressTableView.snp.makeConstraints {
            $0.top.equalTo(stageProgressLabel.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(52)
            $0.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(0)
        }
        
        stageProgressCircleStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(stageProgressTableView).inset(16)
            $0.leading.equalToSuperview().inset(28)
            $0.width.equalTo(13)
        }
        
        reloadButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.centerY.equalTo(stageProgressLabel)
            $0.width.height.equalTo(18)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
