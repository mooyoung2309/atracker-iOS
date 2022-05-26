//
//  ApplicationReviewEditVM.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/26.
//

import Foundation
import RxSwift
import RxCocoa

class ApplicationReviewEditVM: ViewModel {
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let isClickEditButton = PublishSubject<Bool>()
    }
    
    struct Output {
        let isClickedEditButton = BehaviorRelay(value: false)
        let applicationProgresses = BehaviorRelay(value: Const.Test.ApplicationProgressTests)
    }
    
    init() {
        setupBind()
    }
}

extension ApplicationReviewEditVM {
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
    }
}
