//
//  generalMethods.swift
//  grability
//
//  Created by Mario Vizcaino on 21/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func alert(message:String){
        let alert = UIAlertController(title: "TestApp", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Accept", style: .default, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
