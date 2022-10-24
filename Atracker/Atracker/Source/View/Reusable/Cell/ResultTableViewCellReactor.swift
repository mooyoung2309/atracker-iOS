//
//  ResultTableViewCellReactor.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/22.
//

import ReactorKit

class ResultTableViewCellReator: Reactor {
    enum Action { }
    
    enum Mutation { }
    
    struct State {
        var title: String
        var highlight: String
    }
    
    var initialState: State
    
    init(state: State) {
        initialState = state
    }
}
