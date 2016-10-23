//
//  APIService.swift
//  BAMC
//
//  Created by Navneet Kumar on 23/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class APIService: NSObject {
    static let sharedInstance = APIService()
    
    static let baseURL =  "http://bamc.netne.net/"
    
    
    func getLeaders(completion: @escaping (_:[Leader]) -> ())  {
        do {
            let opt = try HTTP.GET("http://bamc.netne.net/myrank.php")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                let reponseString = self.sanitize(input: response.text!)
                print("responseString = \(reponseString)")
                let json = JSON(data:reponseString.data(using: .utf8, allowLossyConversion: false)!)
                let leaders: [Leader] =  json.arrayValue.map({ Leader(data:$0) })
                completion(leaders)
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    func getCalories() {
        do {
            let opt = try HTTP.GET("http://bamc.netne.net/myrank.php")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                let reponseString = self.sanitize(input: response.text!)
                print("responseString = \(reponseString)")          }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    func sanitize(input: String) -> String {
        let data = "\r\n<!-- Hosting24 Analytics Code -->\r\n<script type=\"text/javascript\" src=\"http://stats.hosting24.com/count.php\"></script>\r\n<!-- End Of Analytics Code -->\r\n"
        let result = input.replacingOccurrences(of: data, with: "")
        return result
    }

}
