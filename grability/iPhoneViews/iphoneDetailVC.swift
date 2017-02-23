//
//  iphoneDetailVC.swift
//  grability
//
//  Created by Mario Vizcaino on 21/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import UIKit

class iphoneDetailVC: UIViewController {

    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appPrice: UILabel!
    @IBOutlet weak var appDate: UILabel!
    @IBOutlet weak var appSumary: UITextView!
    var imageApp:UIImage?
    var nameApp:String?
    var priceApp:String?
    var dateApp:String?
    var sumaryApp:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    init(withdata name: String, price: String, date: String, sumary: String, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageApp = image
        priceApp = price == "0.00000" ? "Gratis" : price
        nameApp = name
        dateApp = date
        sumaryApp = sumary
        
    }
    
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension iphoneDetailVC{
    func setupView(){
        //Setup data for the View
        appImage.image = imageApp
        appName.text = nameApp
        appPrice.text = priceApp
        appDate.text = dateApp
        appSumary.text = sumaryApp
        
        //Setup view Styles
        viewStyle()
    }
    func viewStyle() {
        appImage.layer.cornerRadius = 15
        appImage.clipsToBounds = true
        
        appSumary!.layer.borderWidth = 0.5
        appSumary!.layer.borderColor = UIColor.gray.cgColor
        appSumary!.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
    }
}
