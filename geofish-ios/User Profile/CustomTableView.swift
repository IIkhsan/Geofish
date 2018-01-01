//
//  CustomTableView.swift
//  geofish-ios
//
//  Created by Ilyas on 26.12.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    
    var height: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else {return}
        
        if let imageView = header.subviews.first as? UIImageView{
            height = imageView.constraints.filter{ $0.identifier == "height"}.first
            print(height)
            bottom = header.constraints.filter{ $0.identifier == "bottom"}.first
        }
        
        let offsetY = -contentOffset.y
        bottom?.constant = offsetY >= 0 ? 0 : offsetY / 2
        height?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        
        header.clipsToBounds = offsetY <= 0
    }

}
