//
//  EditApplyStageProgressInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift
import RxCocoa

protocol EditApplyStageProgressRouting: ViewableRouting {
}

protocol EditApplyStageProgressPresentable: Presentable {
    var listener: EditApplyStageProgressPresentableListener? { get set }
    var action: EditApplyStageProgressPresentableAction? { get }
    var handler: EditApplyStageProgressPresentableHandler? { get set }
}

protocol EditApplyStageProgressListener: AnyObject {
    func didTapBackButtonFromEditApplyStageProgressRIB()
    func didEditApplyStageProgress()
}

final class EditApplyStageProgressInteractor: PresentableInteractor<EditApplyStageProgressPresentable>, EditApplyStageProgressInteractable, EditApplyStageProgressPresentableListener {
    
    weak var router: EditApplyStageProgressRouting?
    weak var listener: EditApplyStageProgressListener?
    
    private let stageProgressService: StageProgressServiceProtocol
    private let apply: Apply
    private var changedStageProgresses: [StageProgress]
    private var changedStageProgressUpdateRequest: StageProgressUpdateRequest
    
    private let progressStatusRelay = PublishRelay<ProgressStatus>()
    private let stageContentsRelay = BehaviorRelay<[StageContent]>(value: [])
    private let currentPageIndexRelay = BehaviorRelay<Int>(value: 0)
    private let showStatusButtonBarRelay = PublishRelay<Void>()
    private let showDeleteButtonBarRelay = PublishRelay<Void>()
    
    init(presenter: EditApplyStageProgressPresentable, stageProgressService: StageProgressServiceProtocol, apply: Apply) {
        self.apply = apply
        self.stageProgressService = stageProgressService
        self.changedStageProgresses = apply.stageProgress
        
        var stageProgressUpdateContents: [StageProgressUpdateContent] = []
        for stageProgress in changedStageProgresses {
            let stageProgressUpdateContent = StageProgressUpdateContent(deletedContents: [], id: stageProgress.id, newContents: [], status: stageProgress.status, updatedContents: [])
            stageProgressUpdateContents.append(stageProgressUpdateContent)
        }
        
        self.changedStageProgressUpdateRequest = StageProgressUpdateRequest(stageProgressUpdateContents: stageProgressUpdateContents)
        
        super.init(presenter: presenter)
        
        presenter.listener = self
        presenter.handler = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        Log("[D] 후기 수정 디폴트 APPLY \(apply)")
        setupBind()
    }
    
    override func willResignActive() {
        super.willResignActive()
        
        presenter.handler = nil
    }
    
    func setupBind() {
        guard let action = presenter.action else { return }
        guard let handler = presenter.handler else { return }
        
        // bind action
        action.tapBackButton
            .bind { [weak self] in
                self?.listener?.didTapBackButtonFromEditApplyStageProgressRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapNextButton
            .bind { [weak self] in
                guard let this = self else { return }
                this.updateStageProgress(request: this.changedStageProgressUpdateRequest) {
                    Log("[D] API 업데이트 요청 \(this.changedStageProgressUpdateRequest)")
                    this.listener?.didEditApplyStageProgress()
                }
            }
            .disposeOnDeactivate(interactor: self)
        
        action.selectedPageIndex
            .bind { [weak self] i in
                self?.currentPageIndexRelay.accept(i)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.addQNAContentButton
            .bind { [weak self] _ in
                self?.addNewContent(type: StageContentType.QNA)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.addFreeContentButton
            .bind { [weak self] _ in
                self?.addNewContent(type: StageContentType.FREE)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.updatedStageContents
            .bind { [weak self] stageContents in
                self?.emitStageContentsRelay(contents: stageContents)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapProgressStatusButton
            .bind(to: progressStatusRelay)
            .disposeOnDeactivate(interactor: self)
        
        action.tapEditButton
            .bind(to: showDeleteButtonBarRelay)
            .disposeOnDeactivate(interactor: self)
        
        action.tapEditCompleteButton
            .bind(to: showStatusButtonBarRelay)
            .disposeOnDeactivate(interactor: self)
        
        // 핸들러 바인딩
        handler.currentPageIndex
            .bind { [weak self] i in
                guard let this = self else { return }
                Log("[D] 현재 페이지 \(i)")
                this.emitStageContentsRelay(contents: this.changedStageProgresses[i].stageContents)
                this.emitProgressStatusRelay(progressStatusCode: this.changedStageProgresses[i].status)
            }
            .disposeOnDeactivate(interactor: self)
        
        handler.stageContents
            .bind { [weak self] stageContents in
                guard let this = self else { return }
                let index = this.currentPageIndexRelay.value
                this.updateChangedStageProgress(index: index, contents: stageContents)
                this.updateChangedStageProgressUpdateRequest(index: index, originContents: this.apply.stageProgress[index].stageContents, contents: stageContents)
            }
            .disposeOnDeactivate(interactor: self)
        
        handler.progressStatus
            .bind { [weak self] progressStatus in
                guard let this = self else { return }
                let index = this.currentPageIndexRelay.value
                self?.updateProgressStatus(index: index, progressStatus: progressStatus)
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    func updateStageProgress(request: StageProgressUpdateRequest, completion: @escaping () -> ()) {
        stageProgressService.put(request: request) { result in
            switch result {
            case .success(_):
                completion()
                return
            case .failure(let error):
                completion()
                return
            }
        }
    }
    
    private func emitProgressStatusRelay(progressStatusCode: String) {
        switch progressStatusCode {
        case ProgressStatus.notStarted.code:
            progressStatusRelay.accept(ProgressStatus.notStarted)
            return
        case ProgressStatus.fail.code:
            progressStatusRelay.accept(ProgressStatus.fail)
            return
        case ProgressStatus.pass.code:
            progressStatusRelay.accept(ProgressStatus.pass)
            return
        default:
            return
        }
    }
    
    private func emitStageContentsRelay(contents: [StageContent]) {
        var validatedContents = contents
        
        validatedContents = validContainOVERALLContent(contents: validatedContents)
        validatedContents = validOrder(contents: validatedContents)
        
        stageContentsRelay.accept(validatedContents)
    }
    
    private func updateProgressStatus(index: Int, progressStatus: ProgressStatus) {
        changedStageProgresses[index].status = progressStatus.code
        changedStageProgressUpdateRequest.stageProgressUpdateContents[index].status = progressStatus.code
    }
    
    private func updateChangedStageProgress(index: Int, contents: [StageContent]) {
        changedStageProgresses[index].stageContents = contents
    }
    
    private func updateChangedStageProgressUpdateRequest(index: Int, originContents: [StageContent], contents: [StageContent]) {
        changedStageProgressUpdateRequest = updatedStageProgressUpdateRequest(index: index, stageProgressUpdateRequest: changedStageProgressUpdateRequest, originContents: originContents, contents: contents)
    }
    
    private func validContainOVERALLContent(contents: [StageContent]) -> [StageContent] {
        var validatedContents: [StageContent] = contents
        
        // 종합 후기는 필수 항목.
        if contents.contains(where: { $0.contentType == StageContentType.OVERALL.code }) == false {
            validatedContents.append(makeNewContent(type: .OVERALL))
        }
        
        return validatedContents
    }
    
    private func validOrder(contents: [StageContent]) -> [StageContent] {
        var validatedContents: [StageContent] = []
        
        // order은 현재 content의 배열 순서.
        for (i, content) in contents.enumerated() {
            var validatedContent = content
            validatedContent.order = i
            validatedContents.append(validatedContent)
        }
        
        return validatedContents
    }
    
    private func filterNewContents(contents: [StageContent]) -> [StageContent] {
        return contents.filter({ $0.id < 0 })
    }
    
    private func filterDeletedContents(originContents: [StageContent], contents: [StageContent]) -> [StageContent] {
        let originIds = originContents.map({ (content: StageContent) -> Int in
            content.id
        })
        
        // id가 원래 id 배열에 없음. (단, 새롭게 추가된 컨텐츠가 아니어야 함: id 값이 0 보다 커야함)
        return contents.filter({ content in
            content.id > 0 && originIds.contains(where: { $0 == content.id }) == false
        })
    }
    
    private func filterUpdatedContents(originContents: [StageContent], contents: [StageContent]) -> [StageContent] {
        let originIds = originContents.map({ (content: StageContent) -> Int in
            content.id
        })
        
        // id가 원래 id 배열에 있음.
        return contents.filter({ content in
            originIds.contains(where: { $0 == content.id }) == true
        })
    }
    
    private func updatedStageProgressUpdateRequest(index: Int, stageProgressUpdateRequest: StageProgressUpdateRequest, originContents: [StageContent], contents: [StageContent]) -> StageProgressUpdateRequest {
        var updatedStageProgressUpdateRequest = stageProgressUpdateRequest
        
        let filteredDeletedContents = filterDeletedContents(originContents: originContents, contents: contents)
        let filteredNewContents = filterNewContents(contents: contents)
        let filteredUpdateContents = filterUpdatedContents(originContents: originContents, contents: contents)
        
        updatedStageProgressUpdateRequest.stageProgressUpdateContents[index].deletedContents = convertDeletedContents(contents: filteredDeletedContents)
        updatedStageProgressUpdateRequest.stageProgressUpdateContents[index].newContents = convertNewContents(contents: filteredNewContents)
        updatedStageProgressUpdateRequest.stageProgressUpdateContents[index].updatedContents = convertUpdatedContents(contents: filteredUpdateContents)

        return updatedStageProgressUpdateRequest
    }
    
    // 변환 함수
    private func convertNewContents(contents: [StageContent]) -> [NewContent] {
        return contents.map({ (content: StageContent) -> NewContent in
            NewContent(content: content.content ?? "", contentType: content.contentType ?? StageContentType.FREE.code, order: content.order)
        })
    }
    
    private func convertDeletedContents(contents: [StageContent]) -> [DeletedContent] {
        return contents.map({ (content: StageContent) -> DeletedContent in
            DeletedContent(id: content.id)
        })
    }
    
    private func convertUpdatedContents(contents: [StageContent]) -> [UpdatedContent] {
        return contents.map({ (content: StageContent) -> UpdatedContent in
            UpdatedContent(content: content.content ?? "", id: content.id, order: content.order)
        })
    }
    
    private func makeNewContent(type: StageContentType) -> StageContent {
        switch type {
        case .OVERALL:
            return StageContent(id: -1, order: 0, content: "", contentType: StageContentType.OVERALL.code)
        case .QNA:
            return StageContent(id: -1, order: 0, content: "", contentType: StageContentType.QNA.code)
        case .FREE:
            return StageContent(id: -1, order: 0, content: "", contentType: StageContentType.FREE.code)
        }
    }
    
    func addNewContent(type: StageContentType) {
        var contents = stageContentsRelay.value
        var newContent: StageContent
        
        switch type {
        case .OVERALL:
            newContent = StageContent(id: -1, order: 0, content: "", contentType: StageContentType.OVERALL.code)
        case .QNA:
            newContent = StageContent(id: -1, order: 0, content: "", contentType: StageContentType.QNA.code)
        case .FREE:
            newContent = StageContent(id: -1, order: 0, content: "", contentType: StageContentType.FREE.code)
        }
        
        contents.append(newContent)
        
        stageContentsRelay.accept(contents)
    }
}

extension EditApplyStageProgressInteractor: EditApplyStageProgressPresentableHandler {
    var progressStatus: Observable<ProgressStatus> {
        return progressStatusRelay.asObservable()
    }
    
    var stageTitles: Observable<[String]> {
        return Observable.just(apply.stageProgress.map({ (stageProgress: StageProgress) -> String in
            return stageProgress.stageTitle
        }))
    }
    
    var navigationTitle: Observable<String> {
        return Observable.just(apply.companyName)
    }
    
    var stageContents: Observable<[StageContent]> {
        return stageContentsRelay.asObservable()
    }
    
    var currentPageIndex: Observable<Int> {
        return currentPageIndexRelay.asObservable()
    }
    
    var showStatusButtonBar: Observable<Void> {
        return showStatusButtonBarRelay.asObservable()
    }
    
    var showDeleteButtonBar: Observable<Void> {
        return showDeleteButtonBarRelay.asObservable()
    }
}
