//
//  StoryboardFactory.swift
//  Evo
//
//  Created by Ленар Гилязов on 17.01.18.
//  Copyright © 2018 Evo. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    case slideMenu       = "SlideMenu"
    case main            = "Main"
    case news            = "News"
    case map             = "Map"
    case profile         = "Profile"
    case clubs           = "Clubs"
    case search          = "Search"
}

/// Перечисление контроллеров, которые можно загружать из storyboard
enum AppModule: String {
    case newsDetail     = "NewsDetailViewController"
}

typealias StoryboardDataSourceConfiguration = (UIStoryboard)

/// Фабрика storyboard
protocol StoryboardFactory {
    
    /// Получить storyboard по перечислению AppStoryboard
    ///
    /// - Parameter name: тип storyboard
    func getStoryboard(with name: AppStoryboard) -> StoryboardDataSourceConfiguration
}

extension UIStoryboard {
    
    /// Создать контроллер по перечислению AppModule
    ///
    /// - Parameter module: тип контроллера
    func instantiateViewController(for module: AppModule) -> UIViewController {
        return instantiateViewController(withIdentifier: module.rawValue)
    }
}
