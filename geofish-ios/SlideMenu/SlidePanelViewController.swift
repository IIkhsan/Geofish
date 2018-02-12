//
//  SlidePanelViewController.swift
//  geofish-ios
//
//  Created by Ilyas on 08.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class SlidePanelViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SlidePanelViewControllerDelegate?
    var menuPoints: Array<Menu>!
    
    enum CellIdentifier{
        static let MenuCell = "menuCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
}

extension SlidePanelViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.MenuCell, for: indexPath) as! MenuTableViewCell
        cell.configurationForMenu(menuPoints[indexPath.row])
        return cell
    }
}

extension SlidePanelViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = menuPoints[indexPath.row]
        delegate?.didSelectMenu(menu)
    }
}
