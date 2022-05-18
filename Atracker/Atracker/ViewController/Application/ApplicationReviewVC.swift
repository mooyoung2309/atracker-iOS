//
//  ApplicationReviewVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit
import Then

class ApplicationReviewVC: UIViewController {
    var application: Application!
    var titleLabel = UILabel().then {
        $0.text = "우리은행 인턴"
        $0.textColor = Const.Color.mint
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    var progressBarView = UIView().then {
        $0.backgroundColor = Const.Color.orange
    }
    var progressTextTableView = UITableView().then {
        $0.register(ApplicationReviewTableViewCell.self, forCellReuseIdentifier: ApplicationReviewTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .singleLine
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        $0.rowHeight = 80
    }
    var progressTextTableViewAdaptor: ApplicationReviewTableViewAdaptor!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(application: Application) {
        super.init(nibName: nil, bundle: nil)
        self.application = application
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = Const.Color.white
        setView()
    }
}

extension ApplicationReviewVC {
    func updateTableView() {
//        progressTextTableViewAdaptor.update(applicationProgress: <#T##[Application]#>)
    }
    
    func setView() {
        progressTextTableViewAdaptor = ApplicationReviewTableViewAdaptor(self)
        progressTextTableView.delegate = progressTextTableViewAdaptor
        progressTextTableView.dataSource = progressTextTableViewAdaptor
        
        view.addSubview(titleLabel)
        view.addSubview(progressBarView)
        view.addSubview(progressTextTableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBarView.translatesAutoresizingMaskIntoConstraints = false
        progressTextTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            progressBarView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            progressBarView.heightAnchor.constraint(equalToConstant: 20),
            
            progressTextTableView.topAnchor.constraint(equalTo: progressBarView.bottomAnchor),
            progressTextTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressTextTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            progressTextTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
