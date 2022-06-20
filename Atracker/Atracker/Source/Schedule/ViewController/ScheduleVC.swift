////
////  ScheduleVC.swift
////  Atracker
////
////  Created by 송영모 on 2022/05/18.
////
//
//import UIKit
//import SnapKit
//import Then
//
//class ScheduleVC: UIViewController, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    var dates: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
//    let circleIndexs = [3, 5, 10, 20, 29, 16]
//    let lineIndex = 10
//    let lineBackgroundIndex = 24
//    
//    var scrollView = UIScrollView().then {
//        $0.isPagingEnabled = true
//        $0.showsHorizontalScrollIndicator = false
//    }
//    let weekStackView = UIStackView().then {
//        $0.distribution = .fillEqually
//        for week in ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"] {
//            let label = UILabel()
//            label.text = week
//            label.font = .systemFont(ofSize: 15, weight: .regular)
//            label.textColor = .white
//            label.textAlignment = .center
//            $0.addArrangedSubview(label)
//        }
//    }
//    let prevView = UIView().then {
//        $0.backgroundColor = .clear
//    }
//    let nowView = UIView().then {
//        $0.backgroundColor = .clear
//    }
//    let nextView = UIView().then {
//        $0.backgroundColor = .clear
//    }
//    let prevCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
//        $0.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
//        $0.backgroundColor = .clear
//    }
//    let nowCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
//        $0.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
//        $0.backgroundColor = .clear
//    }
//    let nextCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
//        $0.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
//        $0.backgroundColor = .clear
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupProperty()
//        setupHierarchy()
//        setupLayout()
//        prevCalendarCollectionView.reloadData()
//        nowCalendarCollectionView.reloadData()
//        nextCalendarCollectionView.reloadData()
//        scrollView.contentOffset.x = scrollView.frame.width
//    }
//}
//
//extension ScheduleVC {
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        scrollView.contentOffset.x = scrollView.frame.width
//    }
//}
//
//extension ScheduleVC {
//    func setupHierarchy() {
//        view.addSubview(scrollView)
//        
//        scrollView.addSubview(prevView)
//        scrollView.addSubview(nowView)
//        scrollView.addSubview(nextView)
//        
//        prevView.addSubview(prevCalendarCollectionView)
//        nowView.addSubview(nowCalendarCollectionView)
//        nextView.addSubview(nextCalendarCollectionView)
//        
//        view.addSubview(weekStackView)
//    }
//    
//    func setupProperty() {
//        view.backgroundColor = .backgroundGray
//        
//        scrollView.delegate = self
//        prevCalendarCollectionView.delegate = self
//        prevCalendarCollectionView.dataSource = self
//        nowCalendarCollectionView.delegate = self
//        nowCalendarCollectionView.dataSource = self
//        nextCalendarCollectionView.delegate = self
//        nextCalendarCollectionView.dataSource = self
//    }
//    
//    func setupLayout() {
//        
//        
//        scrollView.snp.makeConstraints {
//            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//        
//        prevView.snp.makeConstraints {
//            $0.top.leading.bottom.width.height.equalToSuperview()
//        }
//        
//        nowView.snp.makeConstraints {
//            $0.leading.equalTo(prevView.snp.trailing)
//            $0.top.bottom.width.height.equalToSuperview()
//        }
//        
//        nextView.snp.makeConstraints {
//            $0.leading.equalTo(nowView.snp.trailing)
//            $0.top.trailing.bottom.width.height.equalToSuperview()
//        }
//        
//        view.layoutIfNeeded()
//        let calendarWidth = ceil((nowView.frame.width - 50.0) / 7.0) * 7.0
//        let calendarHeight = 300
//        
//        
//        prevCalendarCollectionView.snp.makeConstraints {
//            $0.width.equalTo(calendarWidth)
//            $0.height.equalTo(calendarHeight)
//            $0.centerX.centerY.equalToSuperview()
//        }
//        
//        nowCalendarCollectionView.snp.makeConstraints {
//            $0.width.equalTo(calendarWidth)
//            $0.height.equalTo(calendarHeight)
//            $0.centerX.centerY.equalToSuperview()
//        }
//        
//        nextCalendarCollectionView.snp.makeConstraints {
//            $0.width.equalTo(calendarWidth)
//            $0.height.equalTo(calendarHeight)
//            $0.centerX.centerY.equalToSuperview()
//        }
//        
//        weekStackView.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalTo(nowCalendarCollectionView.snp.top)
//            $0.width.equalTo(calendarWidth)
//            $0.height.equalTo(50)
//        }
//    }
//}
//
//extension ScheduleVC {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width / 7.0
//        let height = collectionView.frame.height / CGFloat(dates.count / 7 + 1)
//        return CGSize(width: width, height: height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return .zero
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return .zero
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dates.count
//    }
//    
//    
//    // !! HARD-CODING !! FOR - TEST
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        switch collectionView {
//        case prevCalendarCollectionView:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell()}
//            
//            cell.update(date: dates[indexPath.row])
//            cell.showCircle(false)
//            cell.showLine(false)
//            cell.showLineBackground(false)
//            return cell
//        case nowCalendarCollectionView:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell()}
//            
//            cell.update(date: dates[indexPath.row])
//            
//            if circleIndexs.contains(where: { $0 == indexPath.row }) {
//                cell.showCircle(true)
//            } else {
//                cell.showCircle(false)
//            }
//            
//            if indexPath.row == lineIndex - 1 {
//                cell.showLine(true, edge: .left)
//            } else if indexPath.row == lineIndex {
//                cell.showLine(true)
//            } else if indexPath.row == lineIndex + 1 {
//                cell.showLine(true, edge: .right)
//            } else {
//                cell.showLine(false)
//            }
//            
//            if indexPath.row == lineBackgroundIndex - 2 {
//                cell.showLineBackground(true, edge: .left)
//            } else if indexPath.row > lineBackgroundIndex - 2 && indexPath.row < lineBackgroundIndex + 2 {
//                cell.showLineBackground(true)
//            } else if indexPath.row == lineBackgroundIndex + 2 {
//                cell.showLineBackground(true, edge: .right)
//            } else {
//                cell.showLineBackground(false)
//            }
//            
//            return cell
//        case nextCalendarCollectionView:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell()}
//            
//            cell.update(date: dates[indexPath.row])
//            cell.showCircle(false)
//            cell.showLine(false)
//            cell.showLineBackground(false)
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        Log(indexPath)
//    }
//}
