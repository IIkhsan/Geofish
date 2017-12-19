//
//  UserProfileVC.swift
//  geofish-ios
//
//  Created by Ilyas on 17.11.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

let cellID = "cellID"

class UserProfileVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FeedCell.self, forCellReuseIdentifier: cellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
