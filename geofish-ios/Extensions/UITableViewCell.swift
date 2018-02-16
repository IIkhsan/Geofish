
//
//  UITableView.swift
//  geofish-ios
//
//  Created by Ленар Гилязов on 16.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
    
    static var nibName: String {
        return String.init(describing: self.self)
    }
    
    static var cellIdentifier: String {
        return String.init(describing: self.self)
    }
}
