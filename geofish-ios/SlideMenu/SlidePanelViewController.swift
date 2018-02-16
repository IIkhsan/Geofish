//
//  SlidePanelViewController.swift
//  geofish-ios
//
//  Created by Ilyas on 08.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class SlidePanelViewController: UIViewController {
    
    //MARK: - UI переменные
    @IBOutlet weak var nameLabel                : UILabel!
    @IBOutlet weak var userImageView            : UIImageView!
    @IBOutlet weak var sideBarItemsTableView    : UITableView!
    
    //MARK: - Переменные
    var delegate: SlidePanelViewControllerDelegate?
    
}

extension SlidePanelViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
