//
//  GooglePlace.swift
//  geofish-ios
//
//  Created by Ilyas on 13.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

struct LakePlace{
    let name: String
    let coordinate: CLLocationCoordinate2D
    let placeType: Bool
    let numberOfFish: Int
    let rate: Int
    
    init(lat: CGFloat, lng: CGFloat, name: String, numberOfFish: Int, rate: Int, placeType: Bool)
    {
        self.name = name
        self.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(lng))
        self.numberOfFish = numberOfFish
        self.rate = rate
        self.placeType = placeType
    }
    
    static func getAlllakes() -> [LakePlace]{
        return [
            LakePlace(lat: 55.815609, lng: 48.878200, name: "Юдино", numberOfFish: 2, rate: 3, placeType: false),
            LakePlace(lat: 55.814851, lng: 48.889697, name: "Лодочная станция", numberOfFish: 2, rate: 4, placeType: false),
            LakePlace(lat: 55.814266, lng: 48.884054, name: "Место на Куземетьево", numberOfFish: 3, rate: 5, placeType: false)
        ]
    }
}
