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
    
    var applies: [Apply] = []
    
    struct Input {
        let isClickEditButton = PublishSubject<Bool>()
        let isClickPlusQAButton = PublishSubject<Bool>()
        let isClickPlusReviewButton = PublishSubject<Bool>()
    }
    
    struct Output {
        let isClickedEditButton = BehaviorRelay(value: false)
        let isClickedPlusQAButton = PublishRelay<Bool>()
        let isClickedPlusReviewButton = PublishRelay<Bool>()
        let applicationProgresses = BehaviorRelay(value: Const.Test.ApplicationProgressTests)
        let testApplies = BehaviorRelay(value: Const.Test.Applys)
    }
    
    init() {
        setupBind()
    }
}

extension ApplyEditVM {
    func setupBind() {
        input.isClickEditButton
            .withUnretained(self)
            .map { owner, _ in
                if owner.output.isClickedEditButton.value {
                    
                    return false
                } else {
                    return true
                }
            }
            .bind(to: output.isClickedEditButton)
            .disposed(by: disposeBag)
        
        input.isClickPlusQAButton
            .bind(to: output.isClickedPlusQAButton)
            .disposed(by: disposeBag)
        
        input.isClickPlusReviewButton
            .bind(to: output.isClickedPlusReviewButton)
            .disposed(by: disposeBag)
        
        output.isClickedPlusQAButton
            .withUnretained(self)
            .bind { owner, _ in
                var applies = owner.output.testApplies.value
                applies.append(Apply(isChecked: false, type: "QA", content: "새로운 거"))
                owner.output.testApplies.accept(applies)
            }
            .disposed(by: disposeBag)
        
        output.isClickedPlusReviewButton
            .withUnretained(self)
            .bind { owner, _ in
                var applies = owner.output.testApplies.value
                applies.append(Apply(isChecked: false, type: "REVIEW", content: "새로운 거"))
                owner.output.testApplies.accept(applies)
            }
            .disposed(by: disposeBag)
        
        output.testApplies
            .withUnretained(self)
            .bind { owner, applies in
                owner.applies = applies
            }
            .disposed(by: disposeBag)
    }
}
