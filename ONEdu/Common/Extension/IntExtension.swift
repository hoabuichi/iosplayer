//
//  IntExtension.swift
//  ONSports
//
//  Created by will on 22/07/2021.
//

import Foundation

extension Int {
    func secondsToHoursMinutesSeconds() -> String {
        let hour = self / 3600
        let minute = (self % 3600) / 60
        let second = (self % 3600) % 60
        if hour == 0 {
            return String(format: "%0.2d:%0.2d", minute, second)
        }
        return String(format: "%0.2d:%0.2d:%0.2d", hour, minute, second)
    }
    
    func toTimeString() -> String {
        if self < 0 {
            return "Vừa xong"
        }

        let days = self / 3600 / 24
        
        if (days >= 365) {
            return String(format: "%d năm trước", days / 365)
        }
        
        if days >= 30 {
            return String(format: "%d tháng trước", days / 30)
        }
        
        if days > 0 {
            return String(format: "%d ngày trước", days)
        }
        
        let hours = self / 3600
        
        if hours > 0 {
            return String(format: "%d giờ trước", hours)
        }
        
        
        let minutes = (self % 3600) / 60
        
        if minutes > 0 {
            return String(format: "%d phút trước", minutes)
        }
        
        return String(format: "%d giây trước", self)
    }
}
