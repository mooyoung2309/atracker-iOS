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
    var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    var titleLabel = UILabel().then {
        $0.text = "우리은행 인턴"
        $0.textColor = Const.Color.mint
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    var progressTextTableView = UITableView().then {
        $0.register(ApplicationReviewTableViewCell.self, forCellReuseIdentifier: ApplicationReviewTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.backgroundColor = .mainViewColor
        $0.separatorStyle = .singleLine
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorColor = UIColor(hex: 0x292C3F)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0
        $0.layer.borderColor = UIColor.mainViewColor.cgColor
//        $0.rowHeight = 80
    }
    var progressTextTableViewAdaptor: ApplicationReviewTableViewAdaptor!
    var progressTextTableViewHeightConstraint = NSLayoutConstraint()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(application: Application) {
        super.init(nibName: nil, bundle: nil)
        self.application = application
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackGroundColor
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .mainBackGroundColor
        navigationController?.navigationBar.isTranslucent = true
        tabBarController?.hideTabBar()
        setView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        progressTextTableViewHeightConstraint.constant = progressTextTableView.contentSize.height
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(progressTextTableView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressTextTableView.translatesAutoresizingMaskIntoConstraints = false
        
        progressTextTableViewHeightConstraint = progressTextTableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            progressTextTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            progressTextTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressTextTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            progressTextTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            progressTextTableViewHeightConstraint,
        ])
    }
}
