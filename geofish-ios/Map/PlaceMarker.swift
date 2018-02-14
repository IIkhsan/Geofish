//
//  PlaceMaker.swift
//  geofish-ios
//
//  Created by Ilyas on 13.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker{
    let place: LakePlace
    
    init(place: LakePlace){
        self.place = place
        super.init()
        
        position = place.coordinate
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
}
