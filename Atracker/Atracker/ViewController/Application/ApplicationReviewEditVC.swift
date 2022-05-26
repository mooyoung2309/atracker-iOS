//
//  ApplicationReviewEditVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class ApplicationReviewEditVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    let viewModel = ApplicationReviewEditVM()
    var disposeBag = DisposeBag()
    var mockupContents = ["1", "1", "1", "0", "0", "0"]
    let mockupTypes = ["서류", "사전과제", "1차 면접", "2차 면접", "인적성"]
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    let reviewTypeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.register(ReviewTypeCVC.self, forCellWithReuseIdentifier: ReviewTypeCVC.id)
        $0.backgroundColor = .backgroundGray
        $0.showsHorizontalScrollIndicator = false
    }
    let contentTypeButtonStackView = UIStackView().then {
        $0.spacing = 8
    }
    let reviewContentTableView = UITableView().then {
        $0.register(ReviewContentTVC.self, forCellReuseIdentifier: ReviewContentTVC.id)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .backgroundGray
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.isScrollEnabled = false
    }
    
    let awiatButton = RoundButton("대기중", selectedColor: .red)
    let failButton = RoundButton("불합격", selectedColor: .red)
    let passButton = RoundButton("합격", selectedColor: .red)
    let editButton = TextButton("편집", selectedColor: .white)
    
    let plusButtonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 14
    }
    let plusQandAButton = BoxButton("+ 질의응답", selectedColor: .white)
    let plusSumReviewButton = BoxButton("+ 종합후기", selectedColor: .white)
    
    let contentView = UIView().then {
        $0.backgroundColor = .red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGray
        setupHierarchy()
        setupLayout()
        setupProperty()
        setBind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        reviewContentTableView.snp.updateConstraints {
            $0.height.equalTo(reviewContentTableView.contentSize.height)
        }
    }
    
    func isClickedEditButton(_ bool: Bool) {
        let cells = reviewContentTableView.visibleCells
        
        if cells.count > 0 {
            for cell in cells {
                guard let reviewContentTVC = cell as? ReviewContentTVC else { return }
                reviewContentTVC.showCheckButton(bool)
            }
            reviewContentTableView.performBatchUpdates(nil)
        }
    }
}

extension ApplicationReviewEditVC {
    func setupHierarchy() {
        view.addSubview(reviewTypeCollectionView)
        view.addSubview(scrollView)
        view.addSubview(contentTypeButtonStackView)
        view.addSubview(editButton)
        scrollView.addSubview(reviewContentTableView)
        scrollView.addSubview(plusButtonStackView)
    }
    
    func setupLayout() {
        reviewTypeCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        contentTypeButtonStackView.snp.makeConstraints {
            $0.top.equalTo(reviewTypeCollectionView.snp.bottom)
            $0.leading.equalToSuperview().inset(15)
        }
        
        editButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(15)
            $0.centerY.equalTo(contentTypeButtonStackView.snp.centerY)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(contentTypeButtonStackView.snp.bottom).inset(-17)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        reviewContentTableView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(-16)
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(0)
        }
        
        plusButtonStackView.snp.makeConstraints {
            $0.top.equalTo(reviewContentTableView.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(-16)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupProperty() {
        title = "카카오뱅크"
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        reviewTypeCollectionView.delegate = self
        reviewTypeCollectionView.dataSource = self
        reviewContentTableView.delegate = self
        reviewContentTableView.dataSource = self
        
        contentTypeButtonStackView.addArrangedSubviews([awiatButton, failButton, passButton])
        plusButtonStackView.addArrangedSubviews([plusQandAButton, plusSumReviewButton])
    }
    
    func setBind() {
        // !! HARD-CODING !!
        plusQandAButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.mockupContents.append("1")
                owner.reviewContentTableView.insertRows(at: [IndexPath(row: owner.mockupContents.count - 1,
                                                             section: 0)],
                                              with: .automatic)
                owner.reviewContentTableView.beginUpdates()
                owner.reviewContentTableView.snp.updateConstraints {
                    $0.height.equalTo(owner.reviewContentTableView.contentSize.height)
                }
                owner.reviewContentTableView.endUpdates()
            }
            .disposed(by: disposeBag)
        
        editButton.rx.tap
            .map { true }
            .bind(to: viewModel.input.isClickEditButton)
            .disposed(by: disposeBag)
        
        viewModel.output.isClickedEditButton
            .withUnretained(self)
            .bind { owner, bool in
                owner.isClickedEditButton(bool)
            }
            .disposed(by: disposeBag)
    }
}

extension ApplicationReviewEditVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockupTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case reviewTypeCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewTypeCVC.id, for: indexPath) as? ReviewTypeCVC else { return UICollectionViewCell() }

            cell.update(title: mockupTypes[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
}

extension ApplicationReviewEditVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockupContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case reviewContentTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewContentTVC.id, for: indexPath) as? ReviewContentTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            cell.update()
            
            if let reflectWriteView = cell.writeView as? ReflectWriteView {
                reflectWriteView.textChanged { [weak tableView] (_) in
                    self.reviewContentTableView.snp.updateConstraints {
                        $0.height.equalTo(self.reviewContentTableView.contentSize.height)
                    }
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
                }
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
