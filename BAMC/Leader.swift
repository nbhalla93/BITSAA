//
//  Leader.swift
//  BAMC
//
//  Created by Navneet Kumar on 23/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import UIKit
import SwiftyJSON

class Leader: NSObject {
    var name = "nikita"
    var total = "805"
    var email = "nikitabhalla93@gmail.com"
    
    convenience init(data:JSON) {
        self.init()
        name = data["name"].stringValue
        total = data["total"].stringValue
        email = data["email"].stringValue
    }
    
}
