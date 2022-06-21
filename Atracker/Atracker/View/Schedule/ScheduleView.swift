//
//  ScheduleView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import UIKit
import SnapKit

class ScheduleView: BaseView {
    
    let calendarView            = UIView()
    let dateLabel               = UILabel()
    let topDivider              = Divider(.line)
    let weekStackView           = UIStackView()
    let bottomDivider           = Divider(.line)
    let scrollView              = UIScrollView()
    let prevView                = UIView()
    let nowView                 = UIView()
    let nextView                = UIView()
    let leftCollectionView      = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionViewFlowLayout())
    let centerCollectionView    = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionViewFlowLayout())
    let rightCollectionView     = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setupProperty() {
        super.setupProperty()
        
        dateLabel.text          = "2022.06"
        dateLabel.font          = .systemFont(ofSize: 19, weight: .bold)
        dateLabel.textColor     = .neonGreen
        dateLabel.textAlignment = .center
        
        topDivider.alpha = 0.35
        
        bottomDivider.alpha = 0.35
        
        weekStackView.distribution = .fillEqually
        for week in ["월", "화", "수", "목", "금", "토", "일"] {
            let label = UILabel()
            label.text = week
            label.font = .systemFont(ofSize: 15, weight: .regular)
            label.textColor = .white
            label.textAlignment = .center
            weekStackView.addArrangedSubview(label)
        }
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        
        prevView.backgroundColor = .clear
        
        nowView.backgroundColor = .clear
        
        nextView.backgroundColor = .clear
        
        leftCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
        leftCollectionView.backgroundColor = .clear
        
        centerCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
        centerCollectionView.backgroundColor = .clear
        
        rightCollectionView.register(CalendarCVC.self, forCellWithReuseIdentifier: CalendarCVC.id)
        rightCollectionView.backgroundColor = .clear
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(calendarView)
        calendarView.addSubview(dateLabel)
        calendarView.addSubview(topDivider)
        calendarView.addSubview(weekStackView)
        calendarView.addSubview(bottomDivider)
        calendarView.addSubview(scrollView)

        scrollView.addSubview(prevView)
        scrollView.addSubview(nowView)
        scrollView.addSubview(nextView)
        
        prevView.addSubview(leftCollectionView)
        nowView.addSubview(centerCollectionView)
        nextView.addSubview(rightCollectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        calendarView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        
        topDivider.snp.makeConstraints {
            $0.top.equalTo(weekStackView.snp.top).inset(-7)
            $0.leading.trailing.equalToSuperview()
        }
        
        weekStackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(-19)
            $0.leading.trailing.equalToSuperview()
        }
        
        bottomDivider.snp.makeConstraints {
            $0.top.equalTo(weekStackView.snp.bottom).inset(-7)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(weekStackView.snp.bottom).inset(-30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        prevView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }

        nowView.snp.makeConstraints {
            $0.leading.equalTo(prevView.snp.trailing)
            $0.top.bottom.equalToSuperview()
        }

        nextView.snp.makeConstraints {
            $0.leading.equalTo(nowView.snp.trailing)
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        leftCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(Size.calendarWidth)
            $0.height.equalTo(Size.calendarHeight)
        }
        
        centerCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(Size.calendarWidth)
            $0.height.equalTo(Size.calendarHeight)
        }

        centerCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(Size.calendarWidth)
            $0.height.equalTo(Size.calendarHeight)
        }

        rightCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(Size.calendarWidth)
            $0.height.equalTo(Size.calendarHeight)
        }
    }
}



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
