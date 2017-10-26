//
//  DateExtension.swift
//  geofish-ios
//
//  Created by Ilyas on 25.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd-MM-yyyy"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
}
