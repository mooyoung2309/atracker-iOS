//
//  StageProgressUpdateRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation

// MARK: - ApplyResponse
struct StageProgressUpdateRequest: Codable {
    var stageProgressUpdateContents: [StageProgressUpdateContent]

    enum CodingKeys: String, CodingKey {
        case stageProgressUpdateContents = "stage_progresses"
    }
}

// MARK: - StageProgress
struct StageProgressUpdateContent: Codable {
    var deletedContents: [DeletedContent]
    let id: Int
    var newContents: [NewContent]
    var status: String
    var updatedContents: [UpdatedContent]

    enum CodingKeys: String, CodingKey {
        case deletedContents = "deleted_contents"
        case id
        case newContents = "new_contents"
        case status
        case updatedContents = "updated_contents"
    }
}

// MARK: - DeletedContent
struct DeletedContent: Codable {
    let id: Int
}

// MARK: - NewContent
struct NewContent: Codable {
    let content, contentType: String
    let order: Int

    enum CodingKeys: String, CodingKey {
        case content
        case contentType = "content_type"
        case order
    }
}

// MARK: - UpdatedContent
struct UpdatedContent: Codable {
    let content: String
    let id, order: Int
}


