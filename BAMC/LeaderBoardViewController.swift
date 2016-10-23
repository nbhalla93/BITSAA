//
//  LeaderBoardViewController.swift
//  BAMC
//
//  Created by Nikita Bhalla on 23/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import UIKit

class LeaderBoardViewController: UITableViewController {

    var leaders: [Leader] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.sharedInstance.getLeaders { (leaders) in
            print("got leaders = \(leaders)")
            self.leaders = leaders
            self.tableView.reloadData()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaders.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leadercell")
        let leader = self.leaders[indexPath.row]
        cell?.textLabel?.text = leader.name
        return cell!
    }

}
