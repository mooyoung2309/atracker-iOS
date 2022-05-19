//
//  ApplicationViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit
import Then
import RxSwift
import RxCocoa

class ApplicationVC: UIViewController {
    let viewModel = ApplicationVM()
    var disposeBag = DisposeBag()
    
    var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    var positionLabel = UILabel().then {
        $0.text = "신입 UX/UI 디자이너"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = Const.Color.darkGray
    }
    var titleLabel = UILabel().then {
        $0.text = "제시카님의\n지원현황입니다!"
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.textColor = Const.Color.black
        $0.numberOfLines = 0
    }
    var summaryView = SummaryApplicationView().then {
        $0.backgroundColor = Const.Color.white
    }
    var progressTableView = UITableView().then {
        $0.register(ApplicationProgressTableViewCell.self, forCellReuseIdentifier: ApplicationProgressTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .singleLine
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.rowHeight = 80
    }
    var progressTableViewHeightConstraint = NSLayoutConstraint()
    
    var progressTableViewAdaptor: ApplicationProgressTableViewAdaptor!
    var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Const.Color.white
        navigationController?.setNavigationBarHidden(true, animated: false)
        setView()
        setBind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        progressTableViewHeightConstraint.constant = progressTableView.contentSize.height
    }
}

extension ApplicationVC {
    func updateProgressTableView(applicationProgresses: [Application]) {
        progressTableViewAdaptor.update(applicationProgress: applicationProgresses)
        progressTableView.reloadData()
    }
    
    func setView() {
        progressTableViewAdaptor = ApplicationProgressTableViewAdaptor(self)
        progressTableView.delegate = progressTableViewAdaptor
        progressTableView.dataSource = progressTableViewAdaptor
        progressTableView.layer.masksToBounds = true
        progressTableView.layer.borderWidth = 0.33
        
//        pieChartView = PieChartView()
//        pieChartView.backgroundColor = Const.Color.white
        
        view.addSubview(scrollView)
        scrollView.addSubview(positionLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(summaryView)
//        scrollView.addSubview(pieChartView)
        scrollView.addSubview(progressTableView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryView.translatesAutoresizingMaskIntoConstraints = false
//        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        progressTableView.translatesAutoresizingMaskIntoConstraints = false
        
        progressTableViewHeightConstraint = progressTableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            positionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            positionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            positionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            
            summaryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            summaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            summaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            summaryView.heightAnchor.constraint(equalToConstant: 100),
//
//            pieChartView.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 10),
//            pieChartView.heightAnchor.constraint(equalToConstant: 90),
//            pieChartView.widthAnchor.constraint(equalToConstant: 90),
//            pieChartView.centerYAnchor.constraint(equalTo: summaryView.centerYAnchor),
            
            progressTableView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 20),
            progressTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            progressTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            progressTableViewHeightConstraint,
        ])
    }
    
    func setBind() {
        viewModel.output.applicationProgresses
            .withUnretained(self)
            .bind { owner, applicationProgresses in
                owner.updateProgressTableView(applicationProgresses: applicationProgresses)
            }
            .disposed(by: disposeBag)
    }
}
