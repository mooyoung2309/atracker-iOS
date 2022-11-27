//
//  CalendarReactor.swift
//  Atracker
//
//  Created by 송영모 on 2022/11/27.
//

import ReactorKit

class CalendarReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {}
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
}

extension CalendarReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}