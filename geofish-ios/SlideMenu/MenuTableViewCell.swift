//
//  MenuTableViewCell.swift
//  geofish-ios
//
//  Created by Ilyas on 09.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    
    func configurationForMenu(_ menuPoint: Menu) {
        menuImageView.image = menuPoint.image
        menuTitle.text = menuPoint.title
    }
}
