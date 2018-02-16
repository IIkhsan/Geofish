//
//  UserProfileVC.swift
//  geofish-ios
//
//  Created by Ilyas on 17.11.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import QuartzCore

let cellID = "cellID"

class UserProfileVC: UIViewController, ControllerInSideBar {
    @IBOutlet weak var tableView: CustomTableView!
    
    @IBOutlet weak var userAvatarBackgroundImage: UIImageView!
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userClubsLabel: UILabel!
    @IBOutlet weak var userSubscribeLabel: UILabel!
    @IBOutlet weak var userSubscribersLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var delegate: ConteinerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        tableView.register(FeedCell.self, forCellReuseIdentifier: cellID)
    }
    
    @IBAction func sideBarButtonAction(_ sender: UIBarButtonItem) {
        delegate?.currentState == .bothCollapsed ? delegate?.toggleLeftPanel() : delegate?.collapseSlidePanel()
    }
}
