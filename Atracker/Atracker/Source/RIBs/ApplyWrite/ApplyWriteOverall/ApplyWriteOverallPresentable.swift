//
//  ApplyWriteOverallPresentableState.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/29.
//

import Foundation

enum ApplyWriteOverallPresentableAction {
    case refresh
    case textCompany(String)
//    case viewWillAppear
//    case tapBackButton
//    case tapNextButton
//    case tapCompanyCell(Company)
//    case tapAddCompanyCell(String)
//    case tapJobTypeToggleButton
//    case tapJobTypeCell(JobType)
//    case tapStageCell(Stage)
//    case textCompanyName(String)
//    case textJobPosition(String)
}


struct ApplyWriteOverallPresentableState {
    var companySections: [SearchSectionModel] = []
    var jobTypeSections: [SearchSectionModel] = []
    var stageSections: [StageSectionModel] = []
//    var companies: [Company] = []
//    var jobTypes: [JobType] = JobType.list
//    var stages: [Stage] = []
//
//    var updatedCompany: Company? = nil
//    var updatedJobPosition: String? = nil
//    var updatedJobType: JobType? = nil
//    var updatedStages: [Stage] = []
//
//    var showCompanyTableView: Bool = false
//    var showJobTypeTableView: Bool = false
}
