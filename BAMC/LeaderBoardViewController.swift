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
    var everyOneList: [Leader] = []
    var activityIndicator: UIActivityIndicatorView?
    var personalRank = "   Your Rank : "
    var rank = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator?.startAnimating()
        getTopLeaders()
        showMyRank()
    }
    
    func getTopLeaders() {
        APIService.sharedInstance.getLeaders { [weak self] (leaders) in
            guard let strongSelf = self else { return }
            
            print("got leaders = \(leaders)")
            strongSelf.leaders = leaders
            
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
                strongSelf.activityIndicator?.stopAnimating()
            }
            
        }
    }
    
    func showMyRank() {
        APIService.sharedInstance.getMyRank { [weak self] (entireList) in
            guard let strongSelf = self else { return }
            
            strongSelf.everyOneList = entireList
            
            let email = UserDefaults.standard.value(forKey: kemail) as! String
            var i = 1
            
            for user in strongSelf.everyOneList {
                let userEmail = user.email
                i += 1
                if userEmail.caseInsensitiveCompare(email) == .orderedSame {
                    strongSelf.rank = i - 1
                    DispatchQueue.main.async {
                        strongSelf.personalRank = "   Your rank : \(strongSelf.rank)"
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaders.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sview = UIView()
        sview.backgroundColor = UIColor(colorLiteralRed: 0.34, green: 0.13, blue: 0.31, alpha: 1.0)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 210, y: 25, width: 20, height: 20))
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.color = UIColor.white
        
        let myRankView = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: 50.0))
        myRankView.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1.0)
        myRankView.text = personalRank

        sview.addSubview(myRankView)
        
        if let viewActivity = activityIndicator {
            sview.addSubview(viewActivity)
        }
        
        
        let label = UILabel(frame: CGRect(x: 10, y: 25, width: 200, height: 20))
        label.text = "Leaderboard"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.textColor = UIColor.white
        sview.addSubview(label)
        
        return sview
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leadercell")
        let leader = self.leaders[indexPath.row]
        cell?.textLabel?.text = String(indexPath.row + 1) + "   " + leader.name
        cell?.detailTextLabel?.text = leader.total + " " + "Cal"
        return cell!
    }

}
