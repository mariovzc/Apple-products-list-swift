//
//  iPhoneListVC.swift
//  grability
//
//  Created by Mario Vizcaino on 20/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import UIKit

class iPhoneListVC: UIViewController {

    let cellIdentifier = "cellIphone"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellInTable()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerCellInTable() {
        let nib:UINib = UINib(nibName: "iPhoneTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}

extension iPadDetailVC : UITableViewDataSource {
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return arrayData.count
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cell = iPhoneTableViewCell()
        return cell.heigthCell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIphone", for: indexPath) as! iPhoneTableViewCell
        /*
        cell.titleCell.text = arrayData[indexPath.row].name
        cell.descriptionCell.text = arrayData[indexPath.row].price == "0.00000" ? "Gratis" : arrayData[indexPath.row].price
        
        let imgURL: NSURL = NSURL(string: arrayData[indexPath.row].imageUrl
            )!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            if error == nil {
                cell.imageCell.layer.cornerRadius = 5
                cell.imageCell.image = UIImage(data: data!)
            }
        }*/
        
        return cell
    }

    
    
}


extension iPadDetailVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let obj = arrayData[indexPath.row]
        
    }
    
}



