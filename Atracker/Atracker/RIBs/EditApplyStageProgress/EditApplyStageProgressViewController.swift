//
//  EditApplyStageProgressViewController.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift
import UIKit

protocol EditApplyStageProgressPresentableAction: AnyObject {
    var tapNextButton: Observable<Void> { get }
    var tapProgressStatusButton: Observable<ProgressStatus> { get }
    var selectedPageIndex: Observable<Int> { get }
    var addQNAContentButton: Observable<Void> { get }
    var addFreeContentButton: Observable<Void> { get }
    var updatedStageContents: Observable<[StageContent]> { get }
}

protocol EditApplyStageProgressPresentableHandler: AnyObject {
    var navigationTitle: Observable<String> { get }
    var progressStatus: Observable<ProgressStatus> { get }
    var stageTitles: Observable<[String]> { get }
    var stageContents: Observable<[StageContent]> { get }
    var currentPageIndex: Observable<Int> { get }
}

protocol EditApplyStageProgressPresentableListener: AnyObject {
    func tapBackButton()
}

final class EditApplyStageProgressViewController: BaseNavigationViewController, EditApplyStageProgressPresentable, EditApplyStageProgressViewControllable {
    weak var listener: EditApplyStageProgressPresentableListener?
    weak var action: EditApplyStageProgressPresentableAction? {
        return self
    }
    weak var handler: EditApplyStageProgressPresentableHandler?
    
    var thisView: UIView {
        return containerView
    }
    
    private let selfView = EditApplyStageProgressView()
    
    private let tapNextButtonSubject = PublishSubject<Void>()
    private let tapProgressStatusButtonSubject = PublishSubject<ProgressStatus>()
    private let addQNAContentButtonSubject = PublishSubject<Void>()
    private let addFREEContentButtonSubject = PublishSubject<Void>()
    private let selectedPageIndexSubject = PublishSubject<Int>()
    private let updatedStageContentsSubject = PublishSubject<[StageContent]>()
    
    private var stageTitles: [String] = []
    private var stageContents: [StageContent] = []
    
    override func setupNavigaionBar() {
        super.setupNavigaionBar()
        
        showNavigationBarBackButton()
        showNavigationBar()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        selfView.stageTitleCollectionView.delegate = self
        selfView.stageTitleCollectionView.dataSource = self
        selfView.editProgressTableView.delegate = self
        selfView.editProgressTableView.dataSource = self
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
        
        guard let action = action else { return }
        guard let handler = handler else { return }
        
        selfView.nextButton.rx.tap
            .bind { [weak self] in
                self?.emitUpdatedStageContentsSubject()
                self?.tapNextButtonSubject.onNext(())
            }
            .disposed(by: disposeBag)
        
        selfView.statusButtonBar.notStartedButton.rx.tap
            .bind { [weak self] in
                self?.tapProgressStatusButtonSubject.onNext(.notStarted)
            }
            .disposed(by: disposeBag)
        
        selfView.statusButtonBar.failButton.rx.tap
            .bind { [weak self] in
                self?.tapProgressStatusButtonSubject.onNext(.fail)
            }
            .disposed(by: disposeBag)
        
        selfView.statusButtonBar.passButton.rx.tap
            .bind { [weak self] in
                self?.tapProgressStatusButtonSubject.onNext(.pass)
            }
            .disposed(by: disposeBag)
        
        selfView.addQNAContentButton.rx.tap
            .bind { [weak self] in
                self?.emitUpdatedStageContentsSubject()
                self?.addQNAContentButtonSubject.onNext(())
            }
            .disposed(by: disposeBag)
        
        selfView.addFreeContentButton.rx.tap
            .bind { [weak self] in
                self?.emitUpdatedStageContentsSubject()
                self?.addFREEContentButtonSubject.onNext(())
            }
            .disposed(by: disposeBag)
        
        // 핸들러 바인딩
        handler.navigationTitle
            .bind { [weak self] navigationTitle in
                self?.setNavigaionBarTitle(navigationTitle)
            }
            .disposed(by: disposeBag)
        
        handler.stageTitles
            .bind { [weak self] stageTitles in
                self?.reloadStageTitleCollectionView(stageTitles: stageTitles)
            }
            .disposed(by: disposeBag)
        
        handler.stageContents
            .bind { [weak self] stageContents in
                self?.reloadEditProgressTableView(stageContents: stageContents)
            }
            .disposed(by: disposeBag)
        
        handler.progressStatus
            .bind { [weak self] progressStatus in
                self?.reloadProgressStatusButton(progressStatus: progressStatus)
            }
            .disposed(by: disposeBag)
        
        navigaionBar.backButton.rx.tap
            .bind { [weak self] _ in
                self?.listener?.tapBackButton()
            }
            .disposed(by: disposeBag)
    }
    
    func reloadProgressStatusButton(progressStatus: ProgressStatus) {
        selfView.statusButtonBar.notStartedButton.isSelected = false
        selfView.statusButtonBar.failButton.isSelected = false
        selfView.statusButtonBar.passButton.isSelected = false
        
        switch progressStatus {
        case .notStarted:
            selfView.statusButtonBar.notStartedButton.isSelected = true
        case .pass:
            selfView.statusButtonBar.passButton.isSelected = true
        case .fail:
            selfView.statusButtonBar.failButton.isSelected = true
        }
    }
    
    func emitUpdatedStageContentsSubject() {
        updatedStageContentsSubject.onNext(stageContents)
    }
    
    func reloadStageTitleCollectionView(stageTitles: [String]) {
        self.stageTitles = stageTitles
        
        selfView.stageTitleCollectionView.reloadData()
    }
    
    func reloadEditProgressTableView(stageContents: [StageContent]) {
        self.stageContents = stageContents
        
        selfView.editProgressTableView.reloadData()
        refreshTableView(tableView: selfView.editProgressTableView)
    }
}

// MARK: PresenterAction
extension EditApplyStageProgressViewController: EditApplyStageProgressPresentableAction {
    var tapNextButton: Observable<Void> {
        return tapNextButtonSubject.asObservable()
    }
    
    var tapProgressStatusButton: Observable<ProgressStatus> {
        return tapProgressStatusButtonSubject.asObservable()
    }
    
    var selectedPageIndex: Observable<Int> {
        return selectedPageIndexSubject.asObservable()
    }
    
    var addQNAContentButton: Observable<Void> {
        return addQNAContentButtonSubject.asObservable()
    }
    
    var addFreeContentButton: Observable<Void> {
        return addFREEContentButtonSubject.asObservable()
    }
    
    var updatedStageContents: Observable<[StageContent]> {
        return updatedStageContentsSubject.asObserver()
    }
}


// MARK: CollectionView
extension EditApplyStageProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stageTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StageTitleCVC.id, for: indexPath) as? StageTitleCVC else { return UICollectionViewCell() }
        
        cell.update(title: stageTitles[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        emitUpdatedStageContentsSubject()
        selectedPageIndexSubject.onNext(indexPath.item)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? StageTitleCVC else { return }
        
        for cell in collectionView.visibleCells {
            cell.prepareForReuse()
        }
        
        cell.hightlight()
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
extension EditApplyStageProgressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stageContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch stageContents[indexPath.item].contentType {
        case ProgressContentType.OVERALL.code:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EditOVERALLContentTVC.id, for: indexPath) as? EditOVERALLContentTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            cell.update(overallContent: ContentSerialization.shared.toOVERALLContent(string: stageContents[indexPath.item].content))
            
            cell.textChanged { [weak self] (text) in
                guard let this = self else { return }
                this.selfView.editProgressTableView.snp.updateConstraints {
                    $0.height.equalTo(this.selfView.editProgressTableView.contentSize.height)
                }
                this.selfView.editProgressTableView.performBatchUpdates(nil)
                this.stageContents[indexPath.item].content = ContentSerialization.shared.toOVERALLString(overallContent: OVERALLContent(text))
            }
            
            return cell
        case ProgressContentType.QNA.code:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EditQNAContentTVC.id, for: indexPath) as? EditQNAContentTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            cell.update(qnaContent: ContentSerialization.shared.toQNAContent(string: stageContents[indexPath.item].content))

            cell.textChanged { [weak self] (qnaContent) in
                guard let this = self else { return }
                this.selfView.editProgressTableView.snp.updateConstraints {
                    $0.height.equalTo(this.selfView.editProgressTableView.contentSize.height)
                }
                this.selfView.editProgressTableView.performBatchUpdates(nil)
                this.stageContents[indexPath.item].content = ContentSerialization.shared.toQNAString(qnaContent: qnaContent)
            }
            
            return cell
        case ProgressContentType.FREE.code:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EditFREEContentTVC.id, for: indexPath) as? EditFREEContentTVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            cell.update(freeContent: ContentSerialization.shared.toFreeContent(string: stageContents[indexPath.item].content))
            
            cell.textChanged { [weak self] (freeContent) in
                guard let this = self else { return }
                this.selfView.editProgressTableView.snp.updateConstraints {
                    $0.height.equalTo(this.selfView.editProgressTableView.contentSize.height)
                }
                this.selfView.editProgressTableView.performBatchUpdates(nil)
                this.stageContents[indexPath.item].content = ContentSerialization.shared.toFreeString(freeContent: freeContent)
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
