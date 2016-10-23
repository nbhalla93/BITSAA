//
//  User.swift
//  BAMC
//
//  Created by Nikita Bhalla on 09/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation

class User: NSObject {
    var name = "nikita"
    var mobileNumber = "805"
    var emailID = "nikitabha@gmail.com"
    var password = "password"
    
    override init() {
        super.init()
    }
    
    convenience init(sampleName: String, number: String, mail: String, pass: String) {
        self.init()
        
        name = sampleName
        mobileNumber = number
        emailID = mail
        password = pass
    }
}
