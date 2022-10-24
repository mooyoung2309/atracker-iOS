//
//  JobTypeSearchTableViewCellReactor.swift
//  Atracker
//
//  Created by 송영모 on 2022/09/06.
//

import ReactorKit

class JobTypeSearchTableViewCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    var initialState: JobType
    
    init(jobType: JobType) {
        self.initialState = jobType
    }
}
