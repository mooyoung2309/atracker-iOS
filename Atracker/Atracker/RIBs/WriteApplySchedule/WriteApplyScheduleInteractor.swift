//
//  WriteApplyScheduleInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs
import RxSwift

protocol WriteApplyScheduleRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol WriteApplySchedulePresentable: Presentable {
    var listener: WriteApplySchedulePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func updateCalendarCell(prevDate: Date, currentDate: Date, nextDate: Date)
    func setNavigaionBarTitle(_ text: String)
}

protocol WriteApplyScheduleListener: AnyObject {
//    func goBackToWriteApplyOverallRIB()
    func tapBackButtonFromChildRIB()
}

final class WriteApplyScheduleInteractor: PresentableInteractor<WriteApplySchedulePresentable>, WriteApplyScheduleInteractable, WriteApplySchedulePresentableListener {
    
    weak var router: WriteApplyScheduleRouting?
    weak var listener: WriteApplyScheduleListener?

    private var date: Date = Date()
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: WriteApplySchedulePresentable) {
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
    
    func tapBackButton() {
        listener?.tapBackButtonFromChildRIB()
    }
    
    func scrollCalendarPrev() {
        date = date.plusPeriod(Period.month ,interval: -1)
        updateCalendarDates(date: date)
        
    }
    
    func scrollCalendarNext() {
        date = date.plusPeriod(Period.month ,interval: 1)
        updateCalendarDates(date: date)
    }
    
    //MARK: Private
    private func updateCalendarDates(date: Date) {
        let prevDate    = date.plusPeriod(Period.month, interval: -1)
        let currentDate = date
        let nextDate    = date.plusPeriod(Period.month, interval: 1)
        
        presenter.updateCalendarCell(prevDate: prevDate, currentDate: currentDate, nextDate: nextDate)
        presenter.setNavigaionBarTitle(date.getTitleOfMonth())
    }
}
