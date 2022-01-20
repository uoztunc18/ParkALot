//
//  ParkingLot.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import Foundation

struct ParkingLot : Decodable {
    let parkID : Int
    let parkName : String
    let lat : String
    let lng : String
    let capacity : Int
    let emptyCapacity : Int
    let workHours : String
    let parkType : String
    let freeTime : Int
    let district : String
    let isOpen : Int
    
    func isOpenNow() -> Bool {
        let now = Date()
        let calendar = Calendar.current
        
        if self.workHours == "24 Saat" {
             return true
        } else {
            let components = convertToTime(str : self.workHours, calendar : calendar)
            
            let startOfToday = calendar.startOfDay(for: now)
            
            let startTime = calendar.date(byAdding: components.0, to: startOfToday)
            let endTime = calendar.date(byAdding: components.1, to: startOfToday)
            
            if startTime! <= now && now <= endTime! {
                return true
            } else {
                return false
            }
        }
    }
    
    func convertToTime(str : String, calendar : Calendar) -> (DateComponents, DateComponents) {
        let times = str.split(separator: "-")
        let startTime = times[0].split(separator: ":")
        let startHour = Int(startTime[0])
        let startMinute = Int(startTime[1])
        
        let endTime = times[1].split(separator: ":")
        var endHour = Int(endTime[0])
        if endHour == 0 {
           endHour = 24
        }
        let endMinute = Int(endTime[1])
        
        let startTimeComponent = DateComponents(calendar : calendar, hour : startHour, minute : startMinute)
        let endTimeComponent = DateComponents(calendar : calendar, hour : endHour, minute : endMinute)
        
        return (startTimeComponent, endTimeComponent)
    }
    
    func getDistrict() -> String {
        var district = self.district.lowercased()
        
        if district.contains("i̇") {
            district = district.replacingOccurrences(of: "i̇", with: "i")
        }
        return district.capitalized
    }
}
