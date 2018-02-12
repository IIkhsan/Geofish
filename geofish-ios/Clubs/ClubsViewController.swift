//
//  ClubsViewController.swift
//  geofish-ios
//
//  Created by Ilyas on 12.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class ClubsViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 38/255, green: 90/255, blue: 135/255, alpha: 1)
        self.menuButton.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }


}
