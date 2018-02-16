//
//  ConteinerViewControllerDelegate.swift
//  geofish-ios
//
//  Created by Ilyas on 11.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

protocol ConteinerViewControllerDelegate {
    
    var currentState: SlideOutState {get set}
    
    func toggleLeftPanel()
    func collapseSlidePanel()
    
}
