//
//  WriteApplyScheduleViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol WriteApplySchedulePresentableListener: AnyObject {
    func tapBackButton()
    func scrollCalendarPrev()
    func scrollCalendarNext()
}

final class WriteApplyScheduleViewController: BaseNavigationViewController, WriteApplySchedulePresentable, WriteApplyScheduleViewControllable {
    
    var thisView: UIView {
        return containerView
    }
    
    weak var listener: WriteApplySchedulePresentableListener?
    
    let selfView                        = WriteApplyScheduleView()
    
    private var prevDate: Date          = Date()
    private var currentDate: Date       = Date()
    private var nextDate: Date          = Date()
    
    private var prevDates: [Date]       = []
    private var currentDates: [Date]    = []
    private var nextDates: [Date]       = []
    
    private var selectedCellIndexPath: IndexPath?
    private var applyStages: [ApplyStage] = [ApplyStage(eventAt: nil, order: 0, stageID: 0), ApplyStage(eventAt: nil, order: 1, stageID: 1), ApplyStage(eventAt: nil, order: 2, stageID: 2)]
    
    func updateCalendarCell(prevDate: Date, currentDate: Date, nextDate: Date) {
        self.prevDate = prevDate
        self.currentDate = currentDate
        self.nextDate = nextDate
        
        self.prevDates = prevDate.getDatesOfMonth()
        self.currentDates = currentDate.getDatesOfMonth()
        self.nextDates = nextDate.getDatesOfMonth()
        
        selfView.prevCollectionView.reloadData()
        selfView.currentCollectionView.reloadData()
        selfView.nextCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfView.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        selfView.scrollView.contentOffset.x = selfView.scrollView.frame.width
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        showNavigationBar()
        showNavigationBarBackButton()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.scrollView.delegate = self
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        selfView.prevCollectionView.delegate = self
        selfView.prevCollectionView.dataSource = self
        selfView.currentCollectionView.delegate = self
        selfView.currentCollectionView.dataSource = self
        selfView.nextCollectionView.delegate = self
        selfView.nextCollectionView.dataSource = self
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
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
    }
}

extension WriteApplyScheduleViewController: UIScrollViewDelegate {
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

extension WriteApplyScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7.0
        let height = collectionView.frame.height / CGFloat(currentDates.count / 7)
        
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
        case selfView.prevCollectionView:
            return prevDates.count
        case selfView.currentCollectionView:
            return currentDates.count
        case selfView.nextCollectionView:
            return nextDates.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCVC.id, for: indexPath) as? CalendarCVC else { return UICollectionViewCell()}
        
        switch collectionView {
        case selfView.prevCollectionView:
            cell.update(date: prevDates[indexPath.row])
            if prevDate.getMonth() != prevDates[indexPath.row].getMonth() {
                cell.updateTextColor(color: .gray6)
            }
            return cell
        case selfView.currentCollectionView:
            cell.update(date: currentDates[indexPath.row])
            if currentDate.getMonth() != currentDates[indexPath.row].getMonth() {
                cell.updateTextColor(color: .gray6)
            }
            return cell
        case selfView.nextCollectionView:
            cell.update(date: nextDates[indexPath.row])
            if nextDate.getMonth() != nextDates[indexPath.row].getMonth() {
                cell.updateTextColor(color: .gray6)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log("[D] 캘린더 클릭됨. \(indexPath)")
    }
    
}

extension WriteApplyScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applyStages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WriteApplyScheduleTVC.id, for: indexPath) as? WriteApplyScheduleTVC else { return UITableViewCell() }
        
        switch tableView {
        case selfView.tableView:
            cell.selectionStyle = .none
            
            cell.update(date: Date().getDateFromISO8601String(iso8601: applyStages[indexPath.item].eventAt))
            
            if let selectedCellIndexPath = selectedCellIndexPath {
                if selectedCellIndexPath == indexPath {
                    cell.showDatePicker()
                }
            } else {
                cell.hideDatePicker()
            }
            cell.dateChanged { [weak self] date in
                self?.applyStages[indexPath.item].updateEventAt(eventAt: date.getISO8601String())
                
                Log("[D] \(date) \(indexPath)")
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let selectedCellIndexPath = selectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                return 176
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
