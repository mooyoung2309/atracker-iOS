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
    case textJobPosition(String)
    case toggleJobType
    case selectCompany(IndexPath)
    case selectJobType(IndexPath)
    case selectStage(IndexPath)
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
    var companySections: [CompanySearchSectionModel] = []
    var jobTypeSections: [JobTypeSearchSectionModel] = []
    var stageSections: [StageSearchSectionModel] = []
    var companyText: String = ""
    var jobPositionText: String = ""
    var selectedCompany: Company? = nil
    var selectedJobType: JobType? = nil
    var selectedStages: [Stage] = []
    var isHiddenCompany: Bool = true
    var isHiddenJobType: Bool = true
//    var isActiveNextButton: Bool = false
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
