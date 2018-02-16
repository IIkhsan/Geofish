//
//  SidePanelItemTableViewCell.swift
//  geofish-ios
//
//  Created by Ленар Гилязов on 16.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

enum SideBarItemsStatus: Int {
    case inactive = 0
    case active
}

class SidePanelItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var iconImageView    : UIImageView!

    func prepareView(item: SideBarItems, _ status: SideBarItemsStatus) {
        
        titleLabel.text = item.description
        
        switch status {
        case .inactive:
            iconImageView.image = item.inactiveImage
        case .active:
            iconImageView.image = item.activeImage
            titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text         = nil
        titleLabel.textColor    = #colorLiteral(red: 0.2588235294, green: 0.3529411765, blue: 0.5176470588, alpha: 1)
        iconImageView.image     = nil
    }

}
