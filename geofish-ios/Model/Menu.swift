//
//  Menu.swift
//  geofish-ios
//
//  Created by Ilyas on 08.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

struct Menu {
    
    let title: String
    let image: UIImage
    let storyboardName: String
    let viewName: String
    
    init(_ title: String, _ image: UIImage?, _ storyboardName: String, _ viewName: String) {
        self.title = title
        self.image = image!
        self.storyboardName = storyboardName
        self.viewName = viewName
    }
    
    static func allMenuPoints() -> [Menu]{
        return[
            Menu("Новости", UIImage.init(named: "slidebarmenu_icon1"), "News", "NewsViewController"),
            Menu("Карта", UIImage.init(named: "slidebarmenu_icon2"), "", ""),
            Menu("Профиль", UIImage.init(named: "slidebarmenu_icon3"), "Profile", "UserProfileVC"),
            Menu("Клубы", UIImage.init(named: "slidebarmenu_icon4"), "", ""),
            Menu("Поиск", UIImage.init(named: "slidebarmenu_icon5"), "", "")
        ]
    }
}
