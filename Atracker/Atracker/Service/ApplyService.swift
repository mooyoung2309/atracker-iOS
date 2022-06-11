//
//  ApplyService.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import Foundation

protocol ApplyServiceProtocol: class {
    func getApplyList(completion: @escaping ([Apply]) -> Void)
}

class ApplyService: ApplyServiceProtocol {
    func getApplyList(completion: @escaping ([Apply]) -> Void) {
        let applyList = makeApplyList(count: Int.random(in: 8...15))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(applyList)
        }
    }
    
    //MARK: Private
    private func makeStageProgressList(count: Int) -> [StageProgress] {
        var stageProgressList: [StageProgress] = []
        
        for i in 0..<count {
            let stageProgress = StageProgress(content: "테스트 컨텐츠 \(i)", id: i, status: "테스트 상태 \(i)")
            stageProgressList.append(stageProgress)
        }
        
        return stageProgressList
    }
    
    private func makeApplyList(count: Int) -> [Apply] {
        var applyList: [Apply] = []
        
        for i in 0..<count {
            let stageProgressList = makeStageProgressList(count: Int.random(in: 2...10))
            let apply = Apply(applyID: i, companyID: i, companyName: "테스트 회사이름 \(i)", jobPosition: "테스트 잡포지션 \(i)", stageProgress: stageProgressList)
            
            applyList.append(apply)
        }
        
        return applyList
    }
}
