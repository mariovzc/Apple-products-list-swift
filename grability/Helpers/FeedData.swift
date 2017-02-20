//
//  FeedData.swift
//  grability
//
//  Created by Mario Vizcaino on 20/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import Foundation
import Alamofire

class FeedData {
    func data(){
        Alamofire.request("https://itunes.apple.com/us/rss/topfreeapplications/limit=1/json").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}
