//
//  WelcomeVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.navigationController?.setBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
