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
import SnapKit

class ApplyVC: UIViewController {
    let viewModel = ApplyVM()
    var disposeBag = DisposeBag()
    
    var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    var positionLabel = UILabel().then {
        $0.text = "신입 UX/UI 디자이너"
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.textColor = Const.Color.darkGray
    }
    var titleLabel = UILabel().then {
        $0.text = "제시카님의\n지원현황입니다!"
        $0.font = .mainTitle
        $0.textColor = .white
        $0.numberOfLines = 2
    }
    var summaryView = SummaryApplicationView().then {
        $0.backgroundColor = .mainViewColor
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
    }
    var progressTableView = UITableView().then {
        $0.register(ApplySummaryTVC.self, forCellReuseIdentifier: ApplySummaryTVC.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .mainViewColor
        $0.separatorStyle = .singleLine
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorColor = UIColor(hex: 0x292C3F)
        $0.rowHeight = 80
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0
        $0.layer.borderColor = UIColor.mainViewColor.cgColor
    }
    let plusButton = UIButton().then {
        $0.backgroundColor = .gray7
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .neonGreen
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 3, height: 3)
        $0.layer.shadowRadius = 3
        $0.layer.cornerRadius = 20
    }
    
    var progressTableViewHeightConstraint = NSLayoutConstraint()
    
    var progressTableViewAdaptor: ApplicationProgressTableViewAdaptor!
    var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackGroundColor
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.isNavigationBarHidden = true
        
        setView()
        setLayout()
        setBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.showTabBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        progressTableViewHeightConstraint.constant = progressTableView.contentSize.height
    }
}

extension ApplyVC {
    func updateProgressTableView(applicationProgresses: [Application]) {
        progressTableViewAdaptor.update(applicationProgress: applicationProgresses)
        progressTableView.reloadData()
    }
    
    func setLayout() {
        view.addSubview(plusButton)
        
        plusButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
            $0.right.equalToSuperview().inset(36)
            $0.width.height.equalTo(40)
        }
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
            
            positionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            positionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            positionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            
            summaryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            summaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            summaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            summaryView.heightAnchor.constraint(equalToConstant: 100),
//
//            pieChartView.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 10),
//            pieChartView.heightAnchor.constraint(equalToConstant: 90),
//            pieChartView.widthAnchor.constraint(equalToConstant: 90),
//            pieChartView.centerYAnchor.constraint(equalTo: summaryView.centerYAnchor),
            
            progressTableView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 20),
            progressTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            progressTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            progressTableViewHeightConstraint,
        ])
    }
    
    func setBind() {
        plusButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let applicationReviewEditVC = ApplyEditVC()
                owner.navigationController?.pushViewController(applicationReviewEditVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.applicationProgresses
            .withUnretained(self)
            .bind { owner, applicationProgresses in
                owner.updateProgressTableView(applicationProgresses: applicationProgresses)
            }
            .disposed(by: disposeBag)
    }
}
