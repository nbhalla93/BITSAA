//
//  LeaderBoardService.swift
//  BAMC
//
//  Created by Nikita Bhalla on 23/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import SwiftHTTP

class LeaderBoardService: NSObject {
    
    func getLeaders() {
        do {
            let opt = try HTTP.GET("https://google.com")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                print("data is: \(response.data)")            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
}
