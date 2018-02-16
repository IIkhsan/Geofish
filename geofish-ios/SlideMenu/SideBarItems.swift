//
//  asdas.swift
//  geofish-ios
//
//  Created by Ленар Гилязов on 16.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

enum SideBarItems: Int {
    
    case news = 0
    case map
    case profile
    case clubs
    case search
    
    var description: String {
        switch self {
        case .news:
            return "Новости"
        case .map:
            return "Карта"
        case .profile:
            return "Профиль"
        case .clubs:
            return "Клубы"
        case .search:
            return "Поиск"
        }
    }
    
    var appStoryboard: AppStoryboard {
        switch self {
        case .news:
            return AppStoryboard.news
        case .map:
            return AppStoryboard.map
        case .profile:
            return AppStoryboard.profile
        case .clubs:
            return AppStoryboard.clubs
        case .search:
            return AppStoryboard.search
        }
    }
    
    //        var activeImage: UIImage? {
    //            switch self {
    //            case .news:
    //                return UIImage(named: )
    //            case .map:
    //                return UIImage(named: )
    //            case .profile:
    //                return UIImage(named: )
    //            case .clubs:
    //                return UIImage(named: )
    //            case .search:
    //                return UIImage(named: )
    //            }
    //        }
    //
    //        var inactionImage: UIImage? {
    //            switch self {
    //            case .news:
    //                return UIImage(named: )
    //            case .map:
    //                return UIImage(named: )
    //            case .profile:
    //                return UIImage(named: )
    //            case .clubs:
    //                return UIImage(named: )
    //            case .search:
    //                return UIImage(named: )
    //            }
    //        }
}
