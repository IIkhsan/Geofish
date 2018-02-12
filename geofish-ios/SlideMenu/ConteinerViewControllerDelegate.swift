//
//  ConteinerViewControllerDelegate.swift
//  geofish-ios
//
//  Created by Ilyas on 11.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

@objc
protocol ConteinerViewControllerDelegate{
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSlidePanel()
}
