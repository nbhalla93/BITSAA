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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        LeaderBoardService().getLeaders()
        
        
        
    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        
//    }
    
    

}
