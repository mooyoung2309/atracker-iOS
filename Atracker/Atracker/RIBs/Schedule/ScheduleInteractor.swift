//
//  ScheduleInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs
import RxSwift

protocol ScheduleRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SchedulePresentable: Presentable {
    var listener: SchedulePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func updateCalendarCell(prevDate: Date, currentDate: Date, nextDate: Date)
    func updateNavigationTitle(title: String)
    func switchBottomEditButton() -> Bool
    func updateBottomSheet(date: Date)
}

protocol ScheduleListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ScheduleInteractor: PresentableInteractor<SchedulePresentable>, ScheduleInteractable, SchedulePresentableListener {

    weak var router: ScheduleRouting?
    weak var listener: ScheduleListener?
    
    private var date = Date()
    private var selectedDate = Date()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SchedulePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
         updateCalendarDates(date: date)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func scrollCalendarPrev() {
        date = date.plusPeriod(Period.month ,interval: -1)
        updateCalendarDates(date: date)
    }
    
    func scrollCalendarNext() {
        date = date.plusPeriod(Period.month ,interval: 1)
        updateCalendarDates(date: date)
    }
    
    func tapBottomViewEditButton() {
        presenter.switchBottomEditButton()
    }
    
    func tapCalendarView(date: Date) {
        presenter.updateBottomSheet(date: date)
    }
    
    
    //MARK: Private
    private func updateCalendarDates(date: Date) {
        let prevDate    = date.plusPeriod(Period.month, interval: -1)
        let currentDate = date
        let nextDate    = date.plusPeriod(Period.month, interval: 1)
        
        presenter.updateCalendarCell(prevDate: prevDate, currentDate: currentDate, nextDate: nextDate)
        presenter.updateNavigationTitle(title: date.getTitleOfMonth())
    }
}
