//
//  ApplyWriteViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol WriteApplyOverallPresentableListener: AnyObject {
    func tapBackButton()
    func tapNextButton()
    func tapResetButton()
}

final class WriteApplyOverallViewController: BaseNavigationViewController, WriteApplyOverallPresentable, WriteApplyOverallViewControllable {
    
    var thisView: UIView {
        return containerView
    }
    
    weak var listener: WriteApplyOverallPresentableListener?
    
    let selfView = WriteApplyOverallView()
    
    private var selectedIndexPathList: [IndexPath] = []
    
    private let mockups = ["서류", "사전과제", "포트폴리오", "1차 면접", "2차 면접", "3차 면접", "인적성", "코딩테스트", "+ 직접 입력"]
    
    func resetCollectionView() {
        selectedIndexPathList.removeAll()
        selfView.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigaionBar()
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        showNavigationBar()
        showNavigationBarBackButton()
        setNavigaionBarTitle("지원 현황 추가")
    }
    
    override func setupReload() {
        selfView.collectionView.reloadData()
    }
    
    override func setupProperty() {
        super.setupProperty()

        selfView.collectionView.delegate    = self
        selfView.collectionView.dataSource  = self
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
        
        selfView.nextButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapNextButton()
            }
            .disposed(by: disposeBag)
        
        selfView.resetButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapResetButton()
            }
            .disposed(by: disposeBag)
    }
}

extension WriteApplyOverallViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteApplyOverallCVC.id, for: indexPath) as? WriteApplyOverallCVC else { return UICollectionViewCell() }
        
        cell.update(title: mockups[indexPath.item])
        
        if selectedIndexPathList.contains(indexPath) {
            if let order = selectedIndexPathList.firstIndex(of: indexPath) {
                cell.showHighlight(order: order + 1)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPathList.contains(indexPath) {
            selectedIndexPathList.removeElementByReference(indexPath)
        } else {
            selectedIndexPathList.append(indexPath)
        }
        collectionView.reloadItems(at: [indexPath])
        collectionView.reloadData()
        print(selectedIndexPathList)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if selectedIndexPathList.contains(indexPath) {
            return CGSize(width: mockups[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 40,
                          height: 30)
        }
        
        return CGSize(width: mockups[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 20,
                      height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
