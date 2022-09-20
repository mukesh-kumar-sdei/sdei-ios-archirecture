//
//  TimeUtils.swift
//  Maticy
//
//  Created by Amit Shukla on 21/02/20.
//  Copyright © 2020 Maticy. All rights reserved.
//

import Foundation

public enum TUFormat:String {
    case standard   = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case full       = "d MMM yyyy, h:mm a"
    case display    = "dd MMM hh:mm a"
    case card       = "MMYY"
    case payment    = "MM/YY"
    case date       = "yyyy-MM-dd"
    case short      = "dd MMM"
    case time       = "hh:mm a"
}

extension String {
    func date(with formate:TUFormat) -> Date? {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = formate.rawValue
        return dateFormate.date(from: self)
    }
}


extension Date {
    func string(with formate:TUFormat) -> String? {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = formate.rawValue
        return dateFormate.string(from: self)
    }
    
    func utcString() -> String? {
        let dateFormate = DateFormatter()
        dateFormate.calendar = Calendar(identifier: .iso8601)
        dateFormate.locale = Locale.init(identifier: "en-US")
        dateFormate.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormate.dateFormat = TUFormat.standard.rawValue
        return dateFormate.string(from: self)
    }
}
