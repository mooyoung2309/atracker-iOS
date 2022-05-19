//
//  ApplicationProgressDetailViewModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import Foundation
import RxSwift
import RxCocoa

class ApplicationProgressDetailViewModel: ViewModel {
    var disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init() {
        setBind()
    }
}

extension ApplicationProgressDetailViewModel {
    func setBind() {
        
    }
}
