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
        static let ApplicationProgressTests = [
            ApplicationProgress(company: "카카오프렌즈", position: "UI/UX디자이너"),
            ApplicationProgress(company: "네이버파이낸셜", position: "웹 디자이너"),
            ApplicationProgress(company: "오늘의 집", position: "웹 디자이너"),
            ApplicationProgress(company: "우아한 형제들", position: "SNS 컨텐츠 디자이너"),
            ApplicationProgress(company: "쿠팡 플레이", position: "UI/UX디자이너"),
            ApplicationProgress(company: "어트래커1", position: "UI 디자이너"),
            ApplicationProgress(company: "어트래커2", position: "UI 디자이너"),
            ApplicationProgress(company: "어트래커3", position: "UI 디자이너"),
            ApplicationProgress(company: "어트래커4", position: "UI 디자이너"),
            ApplicationProgress(company: "어트래커5", position: "UI 디자이너"),
            ApplicationProgress(company: "어트래커6", position: "UI 디자이너"),
        ]
    }
}
