//
//  NSDate_day.swift
//  ONSports
//
//  Created by Dao Thuy on 7/18/21.
//

import Foundation
extension Date {
    func dayOfTheWeek() -> String? {
        let weekdays = [
            "CN",
            "Thứ 2",
            "Thứ 3",
            "Thứ 4",
            "Thứ 5",
            "Thứ 6",
            "Thứ 7"
        ]
        
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let components: NSDateComponents = calendar.components(.weekday, from: self) as NSDateComponents
        return weekdays[components.weekday - 1]
    }
    
    func getDateFor(days:Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self)
    }
    
    var timeAgoSinceNow: String {
        let time =  Date().toLocalTime().seconds(from: self)
        return time.toTimeString()
    }
    
//    private func getTimeAgoSinceNow() -> String {
//
//        var interval = Calendar.current.dateComponents([.year], from: self, to: Date()).year!
//        if interval > 0 {
//            return interval == 1 ? "\(interval)" + " year" : "\(interval)" + " years"
//        }
//
//        interval = Calendar.current.dateComponents([.month], from: self, to: Date()).month!
//        if interval > 0 {
//            return interval == 1 ? "\(interval)" + " month" : "\(interval)" + " months"
//        }
//
//        interval = Calendar.current.dateComponents([.day], from: self, to: Date()).day!
//        if interval > 0 {
//            return interval == 1 ? "\(interval)" + " day" : "\(interval)" + " days"
//        }
//
//        interval = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour!
//        if interval > 0 {
//            return interval == 1 ? "\(interval)" + " hour" : "\(interval)" + " hours"
//        }
//
//        interval = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute!
//        if interval > 0 {
//            return interval == 1 ? "\(interval)" + " minute" : "\(interval)" + " minutes"
//        }
//
//        return "a moment ago"
//    }
}
