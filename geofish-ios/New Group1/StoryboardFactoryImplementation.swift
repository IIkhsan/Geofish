//
//  StoryboardFactoryImplementation.swift
//  Evo
//
//  Created by Ленар Гилязов on 17.01.18.
//  Copyright © 2018 Evo. All rights reserved.
//

import UIKit

class StoryboardFactoryImplementation: StoryboardFactory {
    
    func getStoryboard(with name: AppStoryboard) -> StoryboardDataSourceConfiguration {
        
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        
        return (storyboard)
    }
}
