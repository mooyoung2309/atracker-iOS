//
//  Const.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import Foundation
import UIKit

struct Const {
    struct Color {
        static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        static let red = UIColor(red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
        static let orange = UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1)
        static let yellow = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)
        static let green = UIColor(red: 48/255, green: 209/255, blue: 88/255, alpha: 1)
        static let mint = UIColor(red: 102/255, green: 212/255, blue: 207/255, alpha: 1)
        static let teal = UIColor(red: 64/255, green: 200/255, blue: 224/255, alpha: 1)
        static let cyan = UIColor(red: 100/255, green: 210/255, blue: 255/255, alpha: 1)
        static let blue = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1)
        static let indigo = UIColor(red: 94/255, green: 92/255, blue: 230/255, alpha: 1)
        static let purple = UIColor(red: 191/255, green: 90/255, blue: 242/255, alpha: 1)
        static let pink = UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)
        static let brown = UIColor(red: 172/255, green: 142/255, blue: 104/255, alpha: 1)
        static let black = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        static let darkGray = UIColor(white: 0.33, alpha: 1)
        static let systemGray = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        static let systemGray2 = UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1)
        static let systemGray3 = UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1)
        static let systemGray4 = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1)
        static let systemGray5 = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        static let systemGray6 = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    }
}

extension Const {
    struct Test {
        static let applyZips = [
            ApplyZipISOLDCODE(applyType: "서류", applies: [
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "서류 QA 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "서류 REVIEW 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "서류 QA 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "서류 REVIEW 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "서류 QA 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "서류 REVIEW 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "서류 QA 테스트 4"),
            ]),
            ApplyZipISOLDCODE(applyType: "사전과제", applies: [
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "사전과제 QA 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "사전과제 REVIEW 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "사전과제 QA 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "사전과제 REVIEW 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "사전과제 QA 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "사전과제 REVIEW 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "사전과제 QA 테스트 4"),
            ]),
            ApplyZipISOLDCODE(applyType: "1차 면접", applies: [
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "1차 면접 QA 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "1차 면접 REVIEW 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "1차 면접 QA 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "1차 면접 REVIEW 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "1차 면접 QA 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "1차 면접 REVIEW 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "1차 면접 QA 테스트 4"),
            ]),
            ApplyZipISOLDCODE(applyType: "2차 면접", applies: [
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "2차 면접 QA 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "2차 면접 REVIEW 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "2차 면접 QA 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "2차 면접 REVIEW 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "2차 면접 QA 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "2차 면접 REVIEW 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "2차 면접 QA 테스트 4"),
            ]),
            ApplyZipISOLDCODE(applyType: "인적성", applies: [
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "인적성 QA 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "인적성 REVIEW 테스트 1"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "인적성 QA 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "인적성 REVIEW 테스트 2"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "인적성 QA 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "인적성 REVIEW 테스트 3"),
                ApplyISOLDCODE(isChecked: false, type: "QA", content: "인적성 QA 테스트 4"),
            ]),
        ]
        
        static let Applys = [
            ApplyISOLDCODE(isChecked: false, type: "QA", content: "QA 테스트 1"),
            ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "REVIEW 테스트 1"),
            ApplyISOLDCODE(isChecked: false, type: "QA", content: "QA 테스트 2"),
            ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "REVIEW 테스트 2"),
            ApplyISOLDCODE(isChecked: false, type: "QA", content: "QA 테스트 3"),
            ApplyISOLDCODE(isChecked: false, type: "REVIEW", content: "REVIEW 테스트 3"),
            ApplyISOLDCODE(isChecked: false, type: "QA", content: "QA 테스트 4"),
        ]
        
        static let ApplicationProgressTests = [
            Application(company: "카카오프렌즈", position: "UI/UX디자이너"),
            Application(company: "네이버파이낸셜", position: "웹 디자이너"),
            Application(company: "오늘의 집", position: "웹 디자이너"),
            Application(company: "우아한 형제들", position: "SNS 컨텐츠 디자이너"),
            Application(company: "쿠팡 플레이", position: "UI/UX디자이너"),
            Application(company: "어트래커1", position: "UI 디자이너"),
            Application(company: "어트래커2", position: "UI 디자이너"),
            Application(company: "어트래커3", position: "UI 디자이너"),
            Application(company: "어트래커4", position: "UI 디자이너"),
            Application(company: "어트래커5", position: "UI 디자이너"),
            Application(company: "어트래커6", position: "UI 디자이너"),
        ]
        
        static let applicationTypeMockUps: [String] = [
            "종합 의견",
            "서류",
            "1차 면접",
            "2차 면접",
        ]
        
        static let applicationContextMockUps: [[String]] = [
            ["다양한 이유가 있겠지만 아마 세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 PT랑 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 은행원이 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다."],
            ["우리은행이 기업금융에 강점을 가진 은행이라 지원했다고 했다. 신용분석사와 투자자산운용사 취득한 내용도 자소서에 넣었고 기업분석대회, 경영시뮬레이션에 참여한 경험도 녹였다. 또한, 부동산에서 중개 아르바이트했던 것을 고객 서비스 경험으로 어필했다."],
            ["Q. 금리가 오르게 되면 은행에 미치는 장단점을 설명해라", "A. PT는 의외였던 것이 종이에다가 유의미한 자료들을 적어서 가지고 들어간후 면접관에게 해당 종이를 어디다 붙여놓고 설명하는 것이 아니라 그냥 들어가자마자 PT내용을 나만 보면서 설명하는것이였다", "Q. 금리가 오르게 되면 은행에 미치는 장단점을 설명해라", "A. PT는 의외였던 것이 종이에다가 유의미한 자료들을 적어서 가지고 들어간후 면접관에게 해당 종이를 어디다 붙여놓고 설명하는 것이 아니라 그냥 들어가자마자 PT내용을 나만 보면서 설명하는것이였다"],
            ["세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다.세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다.세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다.세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다.세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다.세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다.세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다.세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다."],
        ]
    }
}
