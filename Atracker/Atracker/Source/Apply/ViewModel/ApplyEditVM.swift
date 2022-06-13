//
//  ApplyEditVM.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/26.
//

import Foundation
import RxSwift
import RxCocoa

class ApplyEditVM: ViewModel {
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let isClickEditButton = PublishSubject<Bool>()
        let isClickPlusQAButton = PublishSubject<Bool>()
        let isClickPlusReviewButton = PublishSubject<Bool>()
        let isClickDeleteButton = PublishSubject<Bool>()
        let selectTypeIndex = PublishSubject<Int>()
    }
    
    struct Output {
        let isClickedEditButton = BehaviorRelay(value: false)
        let isClickedPlusQAButton = PublishRelay<Bool>()
        let isClickedPlusReviewButton = PublishRelay<Bool>()
        let isClickedDeleteButton = PublishRelay<Bool>()
        let selectedTypeIndex = BehaviorRelay(value: 0)
        let applicationProgresses = BehaviorRelay(value: Const.Test.ApplicationProgressTests)
        let applyZips = BehaviorRelay(value: Const.Test.applyZips)
        let applyZip = BehaviorRelay(value: ApplyZipISOLDCODE(applyType: "", applies: []))
    }
    
    init() {
        setupBind()
    }
}

extension ApplyEditVM {
    func setupBind() {
//        input.isClickEditButton
//            .withUnretained(self)
//            .map { owner, _ in
//                if owner.output.isClickedEditButton.value {
//                    owner.updateIsEditingInApplyZip(bool: false)
//                    return false
//                } else {
//                    owner.updateIsEditingInApplyZip(bool: true)
//                    return true
//                }
//            }
//            .bind(to: output.isClickedEditButton)
//            .disposed(by: disposeBag)
        
        input.isClickPlusQAButton
            .bind(to: output.isClickedPlusQAButton)
            .disposed(by: disposeBag)
        
        input.isClickPlusReviewButton
            .bind(to: output.isClickedPlusReviewButton)
            .disposed(by: disposeBag)
        
        input.isClickDeleteButton
            .bind(to: output.isClickedDeleteButton)
            .disposed(by: disposeBag)
        
        input.selectTypeIndex
            .bind(to: output.selectedTypeIndex)
            .disposed(by: disposeBag)
        
//        output.isClickedPlusQAButton
//            .withUnretained(self)
//            .bind { owner, _ in
//                var applyZip = owner.output.applyZip.value
//                applyZip.applies.append(Apply(isChecked: false, type: "QA", content: "새로운 거"))
//                owner.output.applyZip.accept(applyZip)
//            }
//            .disposed(by: disposeBag)
//
//        output.isClickedPlusReviewButton
//            .withUnretained(self)
//            .bind { owner, _ in
//                var applyZip = owner.output.applyZip.value
//                applyZip.applies.append(Apply(isChecked: false, type: "REVIEW", content: "새로운 거"))
//                owner.output.applyZip.accept(applyZip)
//            }
//            .disposed(by: disposeBag)
//
//        output.isClickedDeleteButton
//            .bind { owner, _ in
//                for apply in owner.output.applyZip.value.applies.filter({ $0.isChecked == true }) {
//                    Log(apply)
//                }
//            }
//            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.applyZips, output.selectedTypeIndex)
            .bind { [weak self] applyZips, index in
                self?.output.applyZip.accept(applyZips[index])
            }
            .disposed(by: disposeBag)
    }
    
    func updateIsEditingInApplyZip(bool: Bool) {
        var applyZip = output.applyZip.value
        applyZip.updateIsEditing(bool: bool)
        output.applyZip.accept(applyZip)
    }
    
    func updateIsCheckInApply(index: Int) {
        var applyZip = output.applyZip.value
        applyZip.applies[index].isChecked = !applyZip.applies[index].isChecked
        output.applyZip.accept(applyZip)
    }
    
    func getCheckedApplyCount() -> Int {
        return output.applyZip.value.applies.filter({ $0.isChecked == true }).count
    }
    
    func deleteCheckedApply() {
        var applyZip = output.applyZip.value
        applyZip.applies.removeAll(where: { $0.isChecked == true })
        output.applyZip.accept(applyZip)
    }
    
}
