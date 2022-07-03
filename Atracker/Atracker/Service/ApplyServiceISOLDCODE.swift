//
//  ApplyService.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import Foundation

protocol ApplyServiceProtocolISOLDCODE: class {
    func getApplyList(completion: @escaping ([ApplyResponse]) -> Void)
}

class ApplyServiceISOLDCODE: ApplyServiceProtocolISOLDCODE {
    func getApplyList(completion: @escaping ([ApplyResponse]) -> Void) {
        let applyList = makeApplyList(count: Int.random(in: 8...15))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(applyList)
        }
    }
    
    //MARK: Private
    private func makeStageProgressList(count: Int) -> [StageProgress] {
        var stageProgressList: [StageProgress] = []
        
        
        for i in 0..<count {
            var stageContent: StageContent
            var stageProgressStatus: String
            
            if Bool.random() {
                stageContent = StageContent(contentType: StageContentType.QNA.code,
                                            content: "QNA 테스트")
            } else {
                stageContent = StageContent(contentType: StageContentType.FREE.code,
                                            content: "FREE 테스트")
            }
            
            switch Int.random(in: 0...2) {
            case 0:
                stageProgressStatus = StageProgressStatus.notStarted.code
                break
            case 1:
                stageProgressStatus = StageProgressStatus.pass.code
                break
            case 2:
                stageProgressStatus = StageProgressStatus.fail.code
                break
            default:
                stageProgressStatus = StageProgressStatus.notStarted.code
                break
            }
            
            let stageProgress = StageProgress(id: i,
                                              title: "전형 \(i)",
                                              stageContent: stageContent,
                                              status: stageProgressStatus)

            stageProgressList.append(stageProgress)
        }
        
        return stageProgressList
    }
    
    private func makeApplyList(count: Int) -> [ApplyResponse] {
        var applyList: [ApplyResponse] = []
        
        for i in 0..<count {
            let stageProgressList = makeStageProgressList(count: Int.random(in: 2...10))
            let apply = ApplyResponse(applyID: i,
                              companyID: i,
                              companyName: "테스트 회사이름 \(i)",
                              jobPosition: "테스트 잡포지션 \(i)",
                              stageProgress: stageProgressList)
            
            applyList.append(apply)
        }
        
        return applyList
    }
}
