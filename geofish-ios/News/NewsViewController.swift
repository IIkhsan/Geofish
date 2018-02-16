//
//  NewsViewController.swift
//  geofish-ios
//
//  Created by Ilyas on 10.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, ControllerInSideBar {

    var delegate: ConteinerViewControllerDelegate?
    
    @IBOutlet weak var tableView: CustomTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 43, green: 33, blue: 69, alpha: 1)
        tableView.register(FeedCell.self, forCellReuseIdentifier: cellID)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sideBarButtonAction(_ sender: UIBarButtonItem) {
        delegate?.currentState == .bothCollapsed ? delegate?.toggleLeftPanel() : delegate?.collapseSlidePanel()
    }
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate{
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
