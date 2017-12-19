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
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FeedCell
        cell.selectionStyle = .none
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
