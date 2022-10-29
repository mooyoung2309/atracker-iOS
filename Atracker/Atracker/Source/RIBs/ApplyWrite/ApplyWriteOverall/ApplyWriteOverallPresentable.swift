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
    case tapBackButton
    case tapNextButton
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
    var isTapBackButton: Bool = false
    var isTapNextButton: Bool = false
}
