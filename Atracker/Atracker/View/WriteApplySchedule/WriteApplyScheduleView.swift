//
//  ApplyWriteDateView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import UIKit
import SnapKit

class WriteApplyScheduleView: BaseView {
    
    let scrollView              = UIScrollView()
    let weekStackView           = UIStackView()
    let prevCollectionView      = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionViewFlowLayout())
    let currentCollectionView   = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionViewFlowLayout())
    let nextCollectionView      = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionViewFlowLayout())
    let tableView   = UITableView()
    let nextButton  = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        weekStackView.distribution = .fillEqually
        for week in ["월", "화", "수", "목", "금", "토", "일"] {
            let label = UILabel()
            label.text = week
            label.font = .systemFont(ofSize: 15, weight: .regular)
            label.textColor = .white
            label.textAlignment = .center
            
            label.snp.makeConstraints {
                $0.height.equalTo(35)
            }
            
            weekStackView.addArrangedSubview(label)
            
        }
        
        weekStackView.addBorders(for: [.top, .bottom], width: 1, color: .gray7)
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        prevCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
        prevCollectionView.backgroundColor = .clear
        
        currentCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
        currentCollectionView.backgroundColor = .clear
        
        nextCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
        nextCollectionView.backgroundColor = .clear
        
        tableView.register(WriteApplyScheduleTVC.self, forCellReuseIdentifier: WriteApplyScheduleTVC.id)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .gray7
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        nextButton.setTitle("완료", for: .normal)
        nextButton.setTitleColor(.neonGreen, for: .normal)
        nextButton.titleLabel?.font     = .systemFont(ofSize: 16, weight: .regular)
        nextButton.backgroundColor      = .backgroundGray
        nextButton.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(weekStackView)
        addSubview(scrollView)
        addSubview(tableView)
        addSubview(nextButton)
        
        scrollView.addSubview(prevCollectionView)
        scrollView.addSubview(currentCollectionView)
        scrollView.addSubview(nextCollectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        weekStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(weekStackView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Size.calendarHeight)
        }
        
        prevCollectionView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(Size.calendarWidth)
            $0.height.equalTo(Size.calendarHeight)
        }
        
        currentCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(prevCollectionView.snp.trailing)
            $0.width.equalTo(Size.calendarWidth)
            $0.height.equalTo(Size.calendarHeight)
        }
        
        nextCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(currentCollectionView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(Size.calendarWidth)
            $0.height.equalTo(Size.calendarHeight)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
