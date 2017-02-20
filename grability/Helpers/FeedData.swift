//
//  FeedData.swift
//  grability
//
//  Created by Mario Vizcaino on 20/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FeedData {
    func updateInfo(){

        let url = "https://itunes.apple.com/us/rss/topfreeapplications/limit=2/json"
        Alamofire.request(url).responseString { response in
            let json = JSON(data: response.data!)
            for (_,subJson):(String, JSON) in json {
                let entry  = subJson["entry"]
                
                /*
                 entry[POSICION DE VALOR ENTRE 1 y 20]
                 var name = entry[0]["im:name"]["label"]
                 var category =  entry[0]["category"]["attributes"]["label"]
                 var imageUrl = entry[0]["im:image"][1]["label"]
                 var summary = entry[0]["summary"]["label"]
                 var price = entry[0]["im:price"]["attributes"]["amount"]
                 var currency = entry[0]["im:price"]["attributes"]["currency"]
                 var releaseDate = entry[0]["im:releaseDate"]["attributes"]["label"]
                 var id = entry[0]["id"]["attributes"]["im:id"]
                 var linkUrl = entry[0]["link"]["attributes"]["href"]
                 
                 */
                
                print(entry[0]["im:releaseDate"]["attributes"]["label"])
            }
            
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
