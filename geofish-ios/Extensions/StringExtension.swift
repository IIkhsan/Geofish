//
//  StringExtension.swift
//  geofish-ios
//
//  Created by Ilyas on 23.11.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

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

extension UIColor {
    
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}
