//
//  NavigationControllerExtensions.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationController{
    func clearColor() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
    
}
