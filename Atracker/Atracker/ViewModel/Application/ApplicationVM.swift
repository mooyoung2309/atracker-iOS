//
//  ApplicationViewModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import Foundation
import RxSwift
import RxCocoa

class ApplicationVM: ViewModel {
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        
    }
    
    struct Output {
        let applicationProgresses = BehaviorRelay(value: Const.Test.ApplicationProgressTests)
    }
    
    init() {
        setBind()
    }
}

extension ApplicationVM {
    func setBind() {
        
    }
}
