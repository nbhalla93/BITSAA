//
//  HomeScreenTabBarController.swift
//  BAMC
//
//  Created by Nikita Bhalla on 23/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenTabBarController: UITabBarController {

    class func instantiateFromStoryboard() -> HomeScreenTabBarController {
        let storyboard = UIStoryboard(name: "LogInViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "HomeScreenTabBarController")
            // swiftlint:disable:next force_cast
            as! HomeScreenTabBarController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = UIColor.white
    }
}
