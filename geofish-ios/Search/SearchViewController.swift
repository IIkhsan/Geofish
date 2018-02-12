//
//  SearchViewController.swift
//  geofish-ios
//
//  Created by Ilyas on 12.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var segmentedController: CustomSegmentedController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedController.items = ["Пользователи","Клубы"]
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 38/255, green: 90/255, blue: 135/255, alpha: 1)
        self.menuButton.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    @IBAction func slideMenu(_ sender: Any){
        
    }

}
