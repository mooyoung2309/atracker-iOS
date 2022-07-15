//
//  ApplyDetailViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol ApplyDetailPresentableAction: AnyObject {
    
}

protocol ApplyDetailPresentableHandler: AnyObject {
    var stageTitles: Observable<[String]> { get }
    var stageProgresses: Observable<[StageProgress]> { get }
}

protocol ApplyDetailPresentableListener: AnyObject {
    func tapBackButton()
    func tapEditButton()
    func tapEditApplyOverallButton()
    func tapEditApplyStageProgressButton()
    func tapDeleteApplyButton()
}

final class ApplyDetailViewController: BaseNavigationViewController, ApplyDetailPresentable, ApplyDetailViewControllable {
    weak var listener: ApplyDetailPresentableListener?
    weak var action: ApplyDetailPresentableAction? {
        return self
    }
    weak var handler: ApplyDetailPresentableHandler?
    
    var thisView: UIView {
        return containerView
    }
    let selfView = ApplyDetailView()
    
    let mockUps = 0...30
    let editTypes = ["지원 후기 수정하기", "전형 편집하기", "지원 후기 삭제하기"]
    
    private var apply: Apply?
    private var stageTitles: [String] = []
    private var stageProgresses: [StageProgress] = []
    
    func showEditTableView() {
        selfView.showEditTableView()
    }
    
    func hideEditTableView() {
        selfView.hideEditTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        refreshTableView(tableView: selfView.stageProgressTableView)
        refreshTableView(tableView: selfView.editTableView)
    }
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        showNavigationBar()
        showNavigationBarBackButton()
        showNavigationBarTrailingButton()
        setNavigationBarTrailingButtonImage(UIImage(named: ImageName.more))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.stageProgressTableView.delegate = self
        selfView.stageProgressTableView.dataSource = self
        selfView.editTableView.delegate = self
        selfView.editTableView.dataSource = self
        selfView.stageTitleCollectionView.delegate = self
        selfView.stageTitleCollectionView.dataSource = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(selfView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selfView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Size.navigationBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        guard let action = action else { return }
        guard let handler = handler else { return }

        handler.stageTitles
            .bind { [weak self] stageTitles in
                self?.reloadStageTitleCollectionView(stageTitles: stageTitles)
            }
            .disposed(by: disposeBag)
        
        handler.stageProgresses
            .bind { [weak self] stageProgresses in
                self?.reloadApplyDetailTableView(stageProgresses: stageProgresses)
            }
            .disposed(by: disposeBag)
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
  
        navigaionBar.trailingButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapEditButton()
            }
            .disposed(by: disposeBag)
    }
    
    func reloadStageTitleCollectionView(stageTitles: [String]) {
        self.stageTitles = stageTitles
        selfView.stageTitleCollectionView.reloadData()
    }
    
    func reloadApplyDetailTableView(stageProgresses: [StageProgress]) {
        self.stageProgresses = stageProgresses
        selfView.stageProgressTableView.reloadData()
        refreshTableView(tableView: selfView.stageProgressTableView)
    }
}

//MARK: PresentableAction
extension ApplyDetailViewController: ApplyDetailPresentableAction {
    
}

//MARK: CollectionView
extension ApplyDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stageTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StageTitleCVC.id, for: indexPath) as? StageTitleCVC else { return UICollectionViewCell() }
        
        cell.update(title: stageTitles[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: stageTitles[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 20,
                      height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}


// MARK: TableView
extension ApplyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case selfView.stageProgressTableView:
            return stageProgresses.count
        case selfView.editTableView:
            return editTypes.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case selfView.stageProgressTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StageProgressTVC.id, for: indexPath) as? StageProgressTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            cell.update(stageProgress: stageProgresses[indexPath.item])
            
            return cell
        case selfView.editTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EditTypeTVC.id, for: indexPath) as? EditTypeTVC else { return UITableViewCell() }
            cell.update(image: UIImage(named: ImageName.trash), title: editTypes[indexPath.item])
            let tmpView = UIView()
            tmpView.backgroundColor = .gray6
            cell.selectedBackgroundView = tmpView
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case selfView.editTableView:
            if indexPath.row == 0 {
                listener?.tapEditApplyOverallButton()
            } else if indexPath.row == 1 {
                listener?.tapEditApplyStageProgressButton()
            } else if indexPath.row == 2 {
                listener?.tapDeleteApplyButton()
            }
            return
        default:
            return
        }
    }
}
