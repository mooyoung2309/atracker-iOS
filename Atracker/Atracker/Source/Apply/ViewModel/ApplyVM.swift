//
//  ApplyVM.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import Foundation
import RxSwift
import RxCocoa

class ApplyVM: ViewModel {
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        
    }
    
    struct Output {
        let applyMockups = BehaviorRelay(value: ["1", "2", "3", "4"])
        let applicationProgresses = BehaviorRelay(value: ConstISOLDCODE.Test.ApplicationProgressTests)
        
        let region = PublishSubject<String>()
    }
    
    init() {
        setBind()
    }
}

extension ApplyVM {
    func setBind() {
        
    }
}
