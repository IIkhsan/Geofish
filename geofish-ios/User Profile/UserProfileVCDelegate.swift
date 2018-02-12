//
//  UserProfileVCDelegate.swift
//  geofish-ios
//
//  Created by Ilyas on 09.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

@objc
protocol UserProfileVCDelegate{
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSlidePanel()
}
