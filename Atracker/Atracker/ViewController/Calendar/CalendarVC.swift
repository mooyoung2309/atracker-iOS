//
//  ScheduleCalendarViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit

class CalendarVC: UIViewController, UIScrollViewDelegate {
    
    var scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    var prevCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    }
    var nowCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    }
    var nextCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    }
    
    var nowCalendarCollectionViewAdaptor: CalendarCollectionViewAdaptor!
    var prevCalendarCollectionViewAdaptor: CalendarCollectionViewAdaptor!
    var nextCalendarCollectionViewAdaptor: CalendarCollectionViewAdaptor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Const.Color.cyan
        setViewAdaptor()
        setView()
        updateCalendarCollectionView()
    }
}

extension CalendarVC {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.x > scrollView.frame.width {
//            self.viewModel.input.date.onNext(try! self.viewModel.input.date.value().plusPeriod(Period.month, interval: 1))
//        } else if scrollView.contentOffset.x < scrollView.frame.width {
//            self.viewModel.input.date.onNext(try! self.viewModel.input.date.value().plusPeriod(Period.month, interval: -1))
//        } else {
//
//        }
        scrollView.contentOffset.x = scrollView.frame.width
    }
}

extension CalendarVC {
    func updateCalendarCollectionView() {
        prevCalendarCollectionView.reloadData()
        nowCalendarCollectionView.reloadData()
        nextCalendarCollectionView.reloadData()
    }
    
    func setViewAdaptor() {
        prevCalendarCollectionViewAdaptor = CalendarCollectionViewAdaptor(self)
        nowCalendarCollectionViewAdaptor = CalendarCollectionViewAdaptor(self)
        nextCalendarCollectionViewAdaptor = CalendarCollectionViewAdaptor(self)
        
        prevCalendarCollectionView.delegate = prevCalendarCollectionViewAdaptor
        prevCalendarCollectionView.dataSource = prevCalendarCollectionViewAdaptor
        
        nowCalendarCollectionView.delegate = nowCalendarCollectionViewAdaptor
        nowCalendarCollectionView.dataSource = nowCalendarCollectionViewAdaptor
        
        nextCalendarCollectionView.delegate = nextCalendarCollectionViewAdaptor
        nextCalendarCollectionView.dataSource = nextCalendarCollectionViewAdaptor
        
        scrollView.delegate = self
    }
    
    func setView() {
        view.addSubview(scrollView)
        scrollView.addSubview(prevCalendarCollectionView)
        scrollView.addSubview(nowCalendarCollectionView)
        scrollView.addSubview(nextCalendarCollectionView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        prevCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        nowCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        nextCalendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            prevCalendarCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            prevCalendarCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            prevCalendarCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            prevCalendarCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            prevCalendarCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            nowCalendarCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            nowCalendarCollectionView.leadingAnchor.constraint(equalTo: prevCalendarCollectionView.trailingAnchor),
            nowCalendarCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            nowCalendarCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            nowCalendarCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            nextCalendarCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            nextCalendarCollectionView.leadingAnchor.constraint(equalTo: nowCalendarCollectionView.trailingAnchor),
            nextCalendarCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            nextCalendarCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            nextCalendarCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            nextCalendarCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}
