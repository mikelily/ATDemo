//
//  DateUtil.swift
//  ATDemo
//
//  Created by 林華淵 on 2022/3/16.
//

import UIKit

class DateUtil: NSObject {
    static let shared = DateUtil()
    
    func getDateFromString(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: strDate)
        dateFormatter.locale = Locale.ReferenceType.system
        dateFormatter.timeZone = TimeZone.ReferenceType.system
       
        return date!
    }

    
    func getWeek() -> String{
        var returnString: String = ""
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.ReferenceType.system
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        
        let calender = Calendar.current
        let weekay = calender.component(.weekday, from: currentDate)
        
        var dateComponet = DateComponents()
        dateComponet.day = -weekay + 1
        let day1 = Calendar.current.date(byAdding: dateComponet, to: currentDate)
        dateFormatter.dateFormat = "YYYY/MM/dd"
        returnString = dateFormatter.string(from: day1!)
        
        dateComponet.day = 7 - weekay
        let day7 = Calendar.current.date(byAdding: dateComponet, to: currentDate)
        dateFormatter.dateFormat = "MM/dd"
        returnString = returnString + " - " + dateFormatter.string(from: day7!)
        
        return returnString
    }
    
    func getWeekDate() -> (Date,Date){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.ReferenceType.system
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        
        let calender = Calendar.current
        let weekay = calender.component(.weekday, from: currentDate)
        
        var dateComponet = DateComponents()
        dateComponet.day = -weekay + 1
        let day1 = Calendar.current.date(byAdding: dateComponet, to: currentDate)!
        
        dateComponet.day = 7 - weekay
        let day7 = Calendar.current.date(byAdding: dateComponet, to: currentDate)!
        
        return (day1,day7)
    }
}
