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
    func scrollCalendarPrev()
    func scrollCalendarNext()
    func tapBottomViewEditButton()
}

final class ScheduleViewController: BaseNavigationViewController, SchedulePresentable, ScheduleViewControllable {
    
    weak var listener: SchedulePresentableListener?
    
    let selfView = ScheduleView()
    
    private let dates: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
    
    private var prevDate: Date          = Date()
    private var currentDate: Date       = Date()
    private var nextDate: Date          = Date()
    
    private var prevDates: [Date]       = []
    private var currentDates: [Date]    = []
    private var nextDates: [Date]       = []
    
    private var selectedCellIndexPath: IndexPath?
    private var canEdit: Bool = false
    
    func updateCalendarCell(prevDate: Date, currentDate: Date, nextDate: Date) {
        self.prevDate       = prevDate
        self.currentDate    = currentDate
        self.nextDate       = nextDate
        
        self.prevDates      = prevDate.getDatesOfMonth()
        self.currentDates   = currentDate.getDatesOfMonth()
        self.nextDates      = nextDate.getDatesOfMonth()
        
        selfView.leftCollectionView.reloadData()
        selfView.centerCollectionView.reloadData()
        selfView.rightCollectionView.reloadData()
    }
    
    func updateNavigationTitle(title: String) {
        setNavigaionBarTitle(title)
    }
    
    func switchBottomEditButton() -> Bool {
        let bool = !selfView.bottomEditButton.isSelected
        
        selfView.bottomEditButton.isSelected = bool
        canEdit = bool
        selectedCellIndexPath = nil
        selfView.bottomTableView.performBatchUpdates(nil, completion: { [weak self] _ in
            self?.selfView.bottomTableView.reloadData()
        })
        
        return bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfView.bottomTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        selfView.scrollView.contentOffset.x = selfView.scrollView.frame.width
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()

        hideNavigationBarBackButton()
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
        selfView.bottomTableView.delegate           = self
        selfView.bottomTableView.dataSource         = self
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
    
    override func setupBind() {
        super.setupBind()
        
        selfView.bottomEditButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapBottomViewEditButton()
            }
            .disposed(by: disposeBag)
    }
}

extension ScheduleViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView {
        case selfView.scrollView:
            if scrollView.contentOffset.x > scrollView.frame.width {
                listener?.scrollCalendarNext()
            } else if scrollView.contentOffset.x < scrollView.frame.width {
                listener?.scrollCalendarPrev()
            }
            scrollView.contentOffset.x = scrollView.frame.width
        default:
            return
        }
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
        switch collectionView {
        case selfView.leftCollectionView:
            return prevDates.count
        case selfView.centerCollectionView:
            return currentDates.count
        case selfView.rightCollectionView:
            return nextDates.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCVC.id, for: indexPath) as? CalendarCVC else { return UICollectionViewCell()}
        
        switch collectionView {
        case selfView.leftCollectionView:
            cell.update(date: prevDates[indexPath.row])
            
            if prevDate.getMonth() != prevDates[indexPath.row].getMonth() {
                cell.updateTextColor(color: .gray6)
            }
            
            return cell
        case selfView.centerCollectionView:
            cell.update(date: currentDates[indexPath.row])
            
            if currentDate.getMonth() != currentDates[indexPath.row].getMonth() {
                cell.updateTextColor(color: .gray6)
            }
            
            return cell
        case selfView.rightCollectionView:
            cell.update(date: nextDates[indexPath.row])
            
            if nextDate.getMonth() != nextDates[indexPath.row].getMonth() {
                cell.updateTextColor(color: .gray6)
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTVC.id, for: indexPath) as? ScheduleTVC else { return UITableViewCell() }
        
        switch tableView {
        case selfView.bottomTableView:
            cell.selectionStyle = .none
            if let selectedCellIndexPath = selectedCellIndexPath {
                if selectedCellIndexPath == indexPath && canEdit {
                    cell.showDatePicker()
                }
            } else {
                cell.hideDatePicker()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let selectedCellIndexPath = selectedCellIndexPath {
            if selectedCellIndexPath == indexPath && canEdit {
                return 220
            }
        }
        return 44
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
        }

        tableView.performBatchUpdates(nil, completion: { _ in
            tableView.reloadData()
        })
    }
}
