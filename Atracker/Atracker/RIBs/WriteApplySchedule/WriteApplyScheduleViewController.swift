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

protocol WriteApplySchedulePresentableAction: AnyObject {
    var scrollCalendar: Observable<Int> { get }
    var tapBackButton: Observable<Void> { get }
    var tapNextButton: Observable<Void> { get }
    var changedApplyCreateStages: Observable<[ApplyCreateStage]> { get }
}

protocol WriteApplySchedulePresentableHandler: AnyObject {
    var date: Observable<Date> { get }
    var applyCreateStages: Observable<[ApplyCreateStage]> { get }
}

protocol WriteApplySchedulePresentableListener: AnyObject {
    
}

final class WriteApplyScheduleViewController: BaseNavigationViewController, WriteApplySchedulePresentable, WriteApplyScheduleViewControllable {
    
    weak var listener: WriteApplySchedulePresentableListener?
    
    weak var action: WriteApplySchedulePresentableAction? {
        return self
    }
    
    weak var handler: WriteApplySchedulePresentableHandler?
    
    let selfView = WriteApplyScheduleView()
    
    private var prevDate = Date()
    private var currentDate = Date()
    private var nextDate = Date()
    private var prevDates: [Date] = []
    private var currentDates: [Date] = []
    private var nextDates: [Date] = []
    
    private let scrollCalendarSubject = PublishSubject<Int>()
    private let changedApplyCreateStagesSubject = PublishSubject<[ApplyCreateStage]>()
    
    private var selectedCellIndexPath: IndexPath?
    private var applyCreateStages: [ApplyCreateStage] = []
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    func reloadCalnedarCollectionView(date: Date) {
        self.prevDate = date.plusPeriod(.month, interval: -1)
        self.currentDate = date
        self.nextDate = date.plusPeriod(.month, interval: 1)
        
        self.prevDates = prevDate.getDatesOfMonth()
        self.currentDates = currentDate.getDatesOfMonth()
        self.nextDates = nextDate.getDatesOfMonth()
        
        selfView.prevCollectionView.reloadData()
        selfView.currentCollectionView.reloadData()
        selfView.nextCollectionView.reloadData()
    }
    
    func reloadApplyStageEventAtTableView(applyCreateStages: [ApplyCreateStage]) {
        self.applyCreateStages = applyCreateStages
        selfView.tableView.reloadData()
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
        
        guard let action = action else { return }
        guard let handler = handler else { return }
        
        handler.date
            .bind { [weak self] date in
                self?.reloadCalnedarCollectionView(date: date)
                self?.setNavigaionBarTitle(date.getTitleOfMonth())
            }
            .disposed(by: disposeBag)
        
        handler.applyCreateStages
            .bind { [weak self] applyCreateStages in
                self?.reloadApplyStageEventAtTableView(applyCreateStages: applyCreateStages)
            }
            .disposed(by: disposeBag)
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
//                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
    }
}

extension WriteApplyScheduleViewController: WriteApplySchedulePresentableAction {
    var scrollCalendar: Observable<Int> {
        return scrollCalendarSubject.asObservable()
    }
    
    var tapBackButton: Observable<Void> {
        return navigaionBar.backButton.rx.tap.asObservable()
    }
    
    var tapNextButton: Observable<Void> {
        return selfView.nextButton.rx.tap.asObservable()
    }
    
    var changedApplyCreateStages: Observable<[ApplyCreateStage]> {
        return changedApplyCreateStagesSubject.asObservable()
    }
}

extension WriteApplyScheduleViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView {
        case selfView.scrollView:
            if scrollView.contentOffset.x > scrollView.frame.width {
                scrollCalendarSubject.onNext(1)
            } else if scrollView.contentOffset.x < scrollView.frame.width {
                scrollCalendarSubject.onNext(-1)
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
    }
    
}

extension WriteApplyScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applyCreateStages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WriteApplyScheduleTVC.id, for: indexPath) as? WriteApplyScheduleTVC else { return UITableViewCell() }
        
        switch tableView {
        case selfView.tableView:
            cell.selectionStyle = .none
            
            cell.update(date: Date().getDateFromISO8601String(iso8601: applyCreateStages[indexPath.item].eventAt))
            
            if let selectedCellIndexPath = selectedCellIndexPath {
                if selectedCellIndexPath == indexPath {
                    cell.showDatePicker()
                }
            } else {
                cell.hideDatePicker()
            }
            cell.dateChanged { [weak self] date in
                self?.applyCreateStages[indexPath.item].updateEventAt(eventAt: date.getISO8601String())
                if let applyCreateStages = self?.applyCreateStages {
                    self?.changedApplyCreateStagesSubject.onNext(applyCreateStages)
                }
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
