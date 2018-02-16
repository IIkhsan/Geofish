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
    var currentControllerItem: SideBarItems!
    
}

//MARK: - Table View Delegate & Data Source
extension SlidePanelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentControllerItem.getCountItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = SideBarItems(rawValue: indexPath.item) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: SidePanelItemTableViewCell.cellIdentifier, for: indexPath) as! SidePanelItemTableViewCell
        
        cell.prepareView(item: item, item == currentControllerItem ? .active : .inactive)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = SideBarItems(rawValue: indexPath.item) else { return }
        currentControllerItem = item
        
        tableView.reloadData()
        delegate?.didSelectMenu(item)
    }
    
}
