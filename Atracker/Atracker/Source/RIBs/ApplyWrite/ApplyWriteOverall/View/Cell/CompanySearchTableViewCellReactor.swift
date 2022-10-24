//
//  CompanySearchTableViewCellReactor.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/06.
//

import ReactorKit

class CompanySearchTableViewCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    var initialState: Company?
    
    init(company: Company?) {
        self.initialState = company
    }
}
