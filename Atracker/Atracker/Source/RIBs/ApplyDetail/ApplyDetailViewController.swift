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
    var tapBackButton: Observable<Void> { get }
    var tapEditButton: Observable<Void> { get }
    var tapEditTypeCell: Observable<EditTypeItem> { get }
}

protocol ApplyDetailPresentableHandler: AnyObject {
    var apply: Observable<Apply> { get }
    var showEditTypeTableView: Observable<Bool> { get }
}

protocol ApplyDetailPresentableListener: AnyObject {
    
}

final class ApplyDetailViewController: BaseNavigationViewController, ApplyDetailPresentable, ApplyDetailViewControllable {
    weak var listener: ApplyDetailPresentableListener?
    weak var action: ApplyDetailPresentableAction? {
        return self
    }
    weak var handler: ApplyDetailPresentableHandler?
    
    let selfView = ApplyDetailView()
    
    private var stageProgresses: [StageProgress] = []
    private var editTypes: [EditTypeItem] = EditTypeItem.list
    
    private let tapEditTypeCellSubject = PublishSubject<EditTypeItem>()
    
    func showEditTableView() {
        selfView.showEditTableView()
    }
    
    func hideEditTableView() {
        selfView.hideEditTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupNavigaionBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        editTypes = EditTypeItem.list
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
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        guard let handler = handler else { return }
        
        handler.apply
            .bind { [weak self] apply in
                self?.didUpdateApply(apply: apply)
            }
            .disposed(by: disposeBag)
        
        handler.showEditTypeTableView
            .bind { [weak self] bool in
                if bool {
                    self?.selfView.showEditTableView()
                } else {
                    self?.selfView.hideEditTableView()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func didUpdateApply(apply: Apply) {
        self.stageProgresses = apply.stageProgress
        setNavigaionBarTitle(apply.companyName)
        selfView.stageTitleCollectionView.reloadData()
        refreshTableView(tableView: selfView.stageProgressTableView)
    }
}

//MARK: PresentableAction
extension ApplyDetailViewController: ApplyDetailPresentableAction {
    var tapBackButton: Observable<Void> {
        return navigaionBar.backButton.rx.tap.asObservable()
    }
    
    var tapEditButton: Observable<Void> {
        return navigaionBar.trailingButton.rx.tap.asObservable()
    }
    
    var tapEditTypeCell: Observable<EditTypeItem> {
        return tapEditTypeCellSubject.asObservable()
    }
}

//MARK: CollectionView
extension ApplyDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stageProgresses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StageTitleCVC.id, for: indexPath) as? StageTitleCVC else { return UICollectionViewCell() }
        
        cell.update(title: stageProgresses[indexPath.item].stageTitle)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: stageProgresses[indexPath.item].stageTitle.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width + 20,
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
            cell.update(editTypeItem: editTypes[indexPath.item])
            
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
            tapEditTypeCellSubject.onNext(editTypes[indexPath.item])
            return
        default:
            return
        }
    }
}
