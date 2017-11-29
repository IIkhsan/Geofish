//
//  StringExtension.swift
//  geofish-ios
//
//  Created by Ilyas on 23.11.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation

extension String{
    
    func toDate() -> Date{
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd.MM.yyyy"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let d = dateStringFormatter.date(from: self)!
        return Date(timeInterval:0, since:d)
    }
    
    func toDateFBBD() -> Date {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd/MM/yyyy"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let d = dateStringFormatter.date(from: self)!
        return Date(timeInterval: 0, since: d)
    }
}
