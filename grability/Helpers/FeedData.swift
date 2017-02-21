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
import CoreData

class FeedData {
    
    var appData: [NSManagedObject] = []
    func updateInfo( handleComplete:(()->())){
        let url = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
        Alamofire.request(url).responseString { response in
            let json = JSON(data: response.data!)
            for (_,subJson):(String, JSON) in json {
                let entries  = subJson["entry"]
                
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
                for entry in entries{
                    if #available(iOS 10.0, *) {
                        self.saveData(name: entry.1["im:name"]["label"],
                                      category: entry.1["category"]["attributes"]["label"],
                                      imageUrl: entry.1["im:image"][1]["label"],
                                      summary: entry.1["summary"]["label"],
                                      price: entry.1["im:price"]["attributes"]["amount"],
                                      currency: entry.1["im:price"]["attributes"]["currency"],
                                      releaseDate: entry.1["im:releaseDate"]["attributes"]["label"],
                                      id: entry.1["id"]["attributes"]["im:id"],
                                      linkUrl: entry.1["link"]["attributes"]["href"])
                    } else {
                        // Fallback on earlier versions
                    }
                }
                //print(entries[0]["im:releaseDate"]["attributes"]["label"])
            }
            
        }
        handleComplete()
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

//CORE DATA METHODS
@available(iOS 10.0, *)
extension FeedData{
    func saveData(name: JSON, category: JSON, imageUrl: JSON, summary: JSON, price: JSON, currency: JSON, releaseDate: JSON, id: JSON, linkUrl: JSON){
        
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: daEntity(),
                                       in: managedContext)!
        
        let app = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        app.setValue(String(describing:name), forKeyPath: "name")
        app.setValue(String(describing:category), forKeyPath: "category")
        app.setValue(String(describing:imageUrl), forKeyPath: "imageUrl")
        app.setValue(String(describing:summary), forKeyPath: "sumary")
        app.setValue(String(describing:price), forKeyPath: "price")
        app.setValue(String(describing:currency), forKeyPath: "currency")
        app.setValue(String(describing:releaseDate), forKeyPath: "releaseDate")
        app.setValue(String(describing:id), forKeyPath: "id")
        app.setValue(String(describing: linkUrl), forKeyPath: "linkUrl")
        
        do {
            try managedContext.save()
            appData.append(app)
            print("saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    func cleanDB(){
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: daEntity())
        
        let result = try? moc.fetch(fetchRequest)
        
        for object in result! {
            moc.delete(object as! NSManagedObject)
            print("deleting")
        }
        
        
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func daEntity() -> String {
        return "Data"
    }
}
