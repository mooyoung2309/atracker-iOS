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
    func didLoad()
}

final class WriteApplyScheduleViewController: BaseNavigationViewController, WriteApplySchedulePresentable, WriteApplyScheduleViewControllable {
    
    var thisView: UIView {
        return containerView
    }
    
    weak var listener: WriteApplySchedulePresentableListener?
    
    let selfView = WriteApplyScheduleView()
    
    private var selectedCellIndexPath: IndexPath?
    
    func presentScheduleView(_ scheduleViewController: ScheduleViewController) {
        let calendarView = scheduleViewController.selfView.calendarView
        
        contentView.subviews.forEach({ $0.removeFromSuperview() })
        
        contentView.addSubview(scheduleViewController.selfView.calendarView)
        contentView.addSubview(selfView)
        
        scheduleViewController.selfView.calendarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(scheduleViewController.selfView.centerCollectionView.snp.bottom)
        }
        
        selfView.snp.makeConstraints {
            $0.top.equalTo(scheduleViewController.selfView.calendarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listener?.didLoad()
        selfView.tableView.reloadData()
    }
    
    func dismissScheduleView() {
        print("HELLO")
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        showNavigationBar()
        showNavigationBarBackButton()
        setNavigaionBarTitle("일정 등록")
    }
    
    override func setupReload() {
        super.setupReload()
        
        selfView.tableView.reloadData()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.tableView.delegate     = self
        selfView.tableView.dataSource   = self
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

extension WriteApplyScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WriteApplyScheduleTVC.id, for: indexPath) as? WriteApplyScheduleTVC else { return UITableViewCell() }
        
        switch tableView {
        case selfView.tableView:
            cell.selectionStyle = .none
            if let selectedCellIndexPath = selectedCellIndexPath {
                if selectedCellIndexPath == indexPath {
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
            if selectedCellIndexPath == indexPath {
                return 300
            }
        }
        return 44
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WriteApplyScheduleTVC.id, for: indexPath) as? WriteApplyScheduleTVC else { return  }
        
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
