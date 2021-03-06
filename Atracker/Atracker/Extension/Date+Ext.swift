//
//  Date.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import Foundation
import UIKit

extension Date {
    func getDateComponentsKST() -> DateComponents {
        if let kst = TimeZone(abbreviation: "KST") {
            return Calendar.current.dateComponents(in: kst, from: self)
        }
        return Calendar.current.dateComponents([.hour, .minute, .second], from: self)
    }
    
    func plusPeriod(_ period: Period = Period.day, interval: Int) -> Date {
        if period == Period.day {
            return Calendar.current.date(byAdding: .day, value: interval, to: self) ?? Date()
        } else if period == Period.week {
            return Calendar.current.date(byAdding: .weekOfYear, value: interval, to: self) ?? Date()
        } else if period == Period.month {
            return Calendar.current.date(byAdding: .month, value: interval, to: self) ?? Date()
        } else if period == Period.year {
            return Calendar.current.date(byAdding: .year, value: interval, to: self) ?? Date()
        } else {
            return Date()
        }
    }
    
    func getDatesOfMonth() -> [Date] {
        var dates: [Date] = []
        var date: Date = Date()
        var dateComponentsKST = self.getDateComponentsKST()
        
        dateComponentsKST.day = 1
        dateComponentsKST.hour = 12
        
        guard let firstDateOfMonth = dateComponentsKST.date else { return [] }
        
        date = firstDateOfMonth
        
        while date.getDateComponentsKST().weekday! != 1 {
            date = date.plusPeriod(Period.day, interval: -1)
            dates.append(date)
        }
        
        dates = dates.reversed()
        
        date = firstDateOfMonth
        
        while date.getDateComponentsKST().month == dateComponentsKST.month || date.getDateComponentsKST().weekday != 1{
            dates.append(date)
            date = date.plusPeriod(Period.day, interval: 1)
        }
        return dates
    }
    
    func getDay() -> Int {
        return self.getDateComponentsKST().day ?? 0
    }
    
    func getWeek() -> String {
        let day = ["월", "화", "수", "목", "금", "토", "일"]
        
        return day[(self.getDateComponentsKST().weekday ?? 1) - 1]
    }
    
    func getMonth() -> Int {
        return self.getDateComponentsKST().month ?? 0
    }
    
    func getTitleOfMonth() -> String {
        let date            = self.getDateComponentsKST().date ?? Date()
        let dateFormatter   = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        
        return dateFormatter.string(from: date)
    }
    
    func getISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        
        return formatter.string(from: self)
    }
    
    func getKRString() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy.MM.dd a hh시 mm분"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        
        return dateFormatter.string(from: self)
    }
    
    func getDateFromISO8601String(iso8601: String?) -> Date? {
        guard let iso8601 = iso8601 else { return nil }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        
        return formatter.date(from: iso8601)
    }
}
