//
//  Date+DateFormatter.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd ''yy"
        return dateFormatter
    }()
    
    static let timestamFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    func toDateString(date: Date) -> String {
        return self.string(from: date)
    }
}

extension Date {
    static func fromUnixTime(unixTime: Double) -> Date {
        let date = Date(timeIntervalSince1970: unixTime)
        return date
    }
    
    func toDateString() -> String {
        return DateFormatter.dateFormatter.string(from: self)
    }
    
    func toTimestampString() -> String {
        return DateFormatter.timestamFormatter.string(from: self)
    }
    
    func toTimeString() -> String {
        return DateFormatter.timeFormatter.string(from: self)
    }
    
    
    func toElapsedInterval(to end: Date = Date()) -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: end)
        
        if let year = interval.year, year > 0{
            guard let month = interval.month, month > 0 else {
                return "\(year) year\(year == 1 ? "":"s") ago"
            }
            return "\(year) year\(year == 1 ? "":"s"), \(month) month\(month == 1 ? "":"s") ago"
        }
        
        if let month = interval.month, month > 0{
            return "\(month) month\(month == 1 ? "":"s") ago"
        }
        
        if let week = interval.weekOfMonth, week > 0{
            return "\(week) week\(week == 1 ? "":"s") ago"
        }
        
        if let day = interval.day, day > 0{
            return "\(day) day\(day == 1 ? "":"s") ago"
        }
        
        if let hour = interval.hour, hour > 0{
            return "\(hour) hour\(hour == 1 ? "":"s") ago"
        }
        
        if let minute = interval.minute, minute > 0{
            return "\(minute) minute\(minute == 1 ? "":"s") ago"
        }
        
        return "A moment ago"
    }
}


