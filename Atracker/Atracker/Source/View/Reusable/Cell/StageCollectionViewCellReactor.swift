//
//  StageCollectionViewCellReactor.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/31.
//

import ReactorKit

class StageCollectionViewCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {
        let order: Int?
        let stage: Stage
    }
    var initialState: State
    
    init(state: State) {
        self.initialState = state
    }
}
