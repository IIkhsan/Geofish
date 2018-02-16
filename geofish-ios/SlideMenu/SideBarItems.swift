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
    
    func getCountItems() -> Int {
        return 5
    }
    
    var activeImage: UIImage? {
        switch self {
        case .news:
            return UIImage(named: "Side-news-active")
        case .map:
            return UIImage(named: "Side-map-active")
        case .profile:
            return UIImage(named: "Side-profile-active")
        case .clubs:
            return UIImage(named: "Side-clubs-active")
        case .search:
            return UIImage(named: "Side-search-active")
        }
    }

    var inactiveImage: UIImage? {
        switch self {
        case .news:
            return UIImage(named: "Side-news-inactive")
        case .map:
            return UIImage(named: "Side-map-inactive")
        case .profile:
            return UIImage(named: "Side-profile-inactive")
        case .clubs:
            return UIImage(named: "Side-clubs-inactive")
        case .search:
            return UIImage(named: "Side-search-inactive")
        }
    }
}
