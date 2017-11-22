//
//  TextFieldExtension.swift
//  geofish-ios
//
//  Created by Ilyas on 17.11.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField



extension UITextField{
    
    enum RegExString: String{
        case email    = "^([a-z0-9_\\.-]+)@([a-z0-9_\\.-]+)\\.([a-z\\.]{2,6})$"
        case password = "[A-Z0-9a-z._%+-]{6,}"
    }
    
    /// Можно использовать проверку как для Email так и для пароля
    func isValid(_ type: RegExString) -> Bool {
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", type.rawValue)
        return emailTest.evaluate(with:self.text)
    }
    
}

extension SkyFloatingLabelTextField{
    
    func clearErrorColor() {
        self.errorMessage = nil
        self.updateColors()
    }
}
