//
//  UserProfileTableExtension.swift
//  geofish-ios
//
//  Created by Ilyas on 17.11.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

extension UserProfileVC: UITableViewDelegate, UITableViewDataSource{
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
