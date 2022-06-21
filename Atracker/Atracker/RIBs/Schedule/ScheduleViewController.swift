//
//  ScheduleViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol SchedulePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ScheduleViewController: BaseNavigationViewController, SchedulePresentable, ScheduleViewControllable {
    
    weak var listener: SchedulePresentableListener?
    
    let selfView = ScheduleView()
    
    private let dates: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        setNavigaionBarTitle("일정")
        hideNavigationBarBackButton()
    }
    
    override func setupReload() {
        super.setupReload()

        selfView.leftCollectionView.reloadData()
        selfView.centerCollectionView.reloadData()
        selfView.rightCollectionView.reloadData()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.leftCollectionView.delegate        = self
        selfView.leftCollectionView.dataSource      = self
        
        selfView.centerCollectionView.delegate      = self
        selfView.centerCollectionView.dataSource    = self
        
        selfView.rightCollectionView.delegate       = self
        selfView.rightCollectionView.dataSource     = self
        
        selfView.scrollView.delegate                = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ScheduleViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = scrollView.frame.width
    }
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7.0
        let height = collectionView.frame.height / CGFloat(dates.count / 7 + 1)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCVC.id, for: indexPath) as? CalendarCVC else { return UICollectionViewCell()}
        
        switch collectionView {
        case selfView.leftCollectionView:
            
            cell.update(date: dates[indexPath.row])
            
            return cell
        case selfView.centerCollectionView:
            
            cell.update(date: dates[indexPath.row])
            
            return cell
        case selfView.rightCollectionView:
            
            cell.update(date: dates[indexPath.row])
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}
