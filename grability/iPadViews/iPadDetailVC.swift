//
//  iPadDetailVC.swift
//  grability
//
//  Created by Mario Vizcaino on 21/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import UIKit

class iPadDetailVC: UIViewController {

    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appPrice: UILabel!
    @IBOutlet weak var appDate: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var appSumary: UITextView!

    
    var imgApp: UIImage?
    var nameApp: String?
    var priceApp: String?
    var dateApp: String?
    var categoryApp: String?
    var sumaryApp: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appImage.image = imgApp
        appName.text = nameApp
        appPrice.text = priceApp
        appDate.text = dateApp
        appCategory.text = categoryApp
        appSumary.text = sumaryApp
        appImage.layer.cornerRadius = 15
        appImage.clipsToBounds = true

    }

    init(withdata name: String, price: String, date: String, category: String, sumary: String, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imgApp = image
        priceApp = price == "0.00000" ? "Gratis" : price
        nameApp = name
        dateApp = date
        categoryApp = category
        sumaryApp = sumary
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func closeButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
