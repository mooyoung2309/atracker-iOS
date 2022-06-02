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

class ApplyVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    let viewModel = ApplyVM()
    let selfView = ApplyView()
    let mockUps = ["이소진 1", "이소진 2", "이소진 3", "이소진 4", "이소진 5", "이소진 6", "이소진 7", "이소진 8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGray
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.barTintColor = .backgroundGray
        tabBarController?.tabBar.isTranslucent = false

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        refreshTableView(tableView: selfView.tableView)
    }
    
    override func setupProperty() {
        super.setupProperty()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        view.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        selfView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        selfView.plusButton.rx.tap
        .withUnretained(self)
        .bind { owner, _ in
            let applicationReviewEditVC = ApplyEditVC()
            owner.navigationController?.pushViewController(applicationReviewEditVC, animated: true)
        }
        .disposed(by: disposeBag)
    }
}
extension ApplyVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockUps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case selfView.tableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplyProgressTVC.id, for: indexPath) as? ApplyProgressTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.update(mokUp: mockUps[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}


extension ApplyVC {
//    func updateProgressTableView(applicationProgresses: [Application]) {
//        progressTableViewAdaptor.update(applicationProgress: applicationProgresses)
//        progressTableView.reloadData()
//    }
//
//    func setLayout() {
//        view.addSubview(plusButton)
//
//        plusButton.snp.makeConstraints {
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
//            $0.right.equalToSuperview().inset(36)
//            $0.width.height.equalTo(40)
//        }
//    }
//
//    func setView() {
//        progressTableViewAdaptor = ApplicationProgressTableViewAdaptor(self)
//        progressTableView.delegate = progressTableViewAdaptor
//        progressTableView.dataSource = progressTableViewAdaptor
//        progressTableView.layer.masksToBounds = true
//        progressTableView.layer.borderWidth = 0.33
//
////        pieChartView = PieChartView()
////        pieChartView.backgroundColor = Const.Color.white
//
//        view.addSubview(scrollView)
//        scrollView.addSubview(positionLabel)
//        scrollView.addSubview(titleLabel)
//        scrollView.addSubview(summaryView)
////        scrollView.addSubview(pieChartView)
//        scrollView.addSubview(progressTableView)
//
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        positionLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        summaryView.translatesAutoresizingMaskIntoConstraints = false
////        pieChartView.translatesAutoresizingMaskIntoConstraints = false
//        progressTableView.translatesAutoresizingMaskIntoConstraints = false
//
//        progressTableViewHeightConstraint = progressTableView.heightAnchor.constraint(equalToConstant: 0)
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
//
//            positionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
//            positionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
//            positionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//
//            titleLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 10),
//            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
//            titleLabel.widthAnchor.constraint(equalToConstant: 300),
//
//            summaryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            summaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            summaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            summaryView.heightAnchor.constraint(equalToConstant: 100),
////
////            pieChartView.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 10),
////            pieChartView.heightAnchor.constraint(equalToConstant: 90),
////            pieChartView.widthAnchor.constraint(equalToConstant: 90),
////            pieChartView.centerYAnchor.constraint(equalTo: summaryView.centerYAnchor),
//
//            progressTableView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 20),
//            progressTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            progressTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            progressTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            progressTableViewHeightConstraint,
//        ])
//    }
    
//    func setBind() {
//
//
//        viewModel.output.applicationProgresses
//            .withUnretained(self)
//            .bind { owner, applicationProgresses in
//                owner.updateProgressTableView(applicationProgresses: applicationProgresses)
//            }
//            .disposed(by: disposeBag)
//    }
}
