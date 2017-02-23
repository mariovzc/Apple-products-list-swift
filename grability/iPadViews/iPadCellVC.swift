//
//  iPadCellVC.swift
//  grability
//
//  Created by Mario Vizcaino on 20/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import UIKit
import CoreData
import ElasticTransition
class iPadCellVC: UIViewController {
    
    let cellIdentifier = "customCell"

    var appData: [NSManagedObject] = []

    let feed  = FeedData()
    
    var transition = ElasticTransition()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup ALL THE THINGS IN THE VIEW
        setupView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        initialData()
    }
    

}
//MARK: - MAIN FUNCTIONS
extension iPadCellVC{
    func setupView(){
        if (self.currentReachabilityStatus == .notReachable) {
            alert(message: "No tienes conexion a internet")
        }
        // REGISTER THE CELL
        registerCellInTable()
        // SETUP INITIAL DATA
        initialData()
        // SETUP NAVIGATION BAR
        navigationBar()
        
        //SETUP TRANSITION
        transition.stiffness = 1
        transition.edge = .top
        transition.sticky = false
    }
    func initialData(){
        if #available(iOS 10.0, *) {
            getData{() -> () in
                if(appData.count > 0){
                    displayData()
                    collectionView.reloadData()
                }else{
                    if (self.currentReachabilityStatus == .notReachable) {
                        alert(message: "No tienes conexion a internet")
                        return
                    }else{
                        feed.cleanDB()
                        feed.updateInfo{ () -> () in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                                self.getData {
                                    self.displayData()
                                    self.collectionView.reloadData()
                                    
                                }
                                
                            })
                        }
                    }
                    
                }
            }
        }
    }
    
    func registerCellInTable() {
        let nib:UINib = UINib(nibName: "IpadCellCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func refresh(){
        displayData()
        self.collectionView.reloadData()
        initialData()
    }
    func navigationBar() {
        
        let navbtn = UIButton(type: .custom)
        navbtn.setImage(UIImage(named: "refresh"), for: .normal)
        navbtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        navbtn.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: navbtn)
        self.navigationItem.rightBarButtonItem = item1
        self.navigationItem.title = "iPad View"
        
    }
    
    func displayData() {
        if #available(iOS 10.0, *) {
            getData {
                print("DATAaaaaaa")
                
            }
        }
        print(appData.count)
        collectionView.reloadData()
    }
    
    @available(iOS 10.0, *)
    func getData(handleComplete:(()->())){
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: feed.daEntity())
        
        do {
            appData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        collectionView.reloadData()
        handleComplete()
    }
    
}

//MARK: - COLLECTION VIEW DATASOURCE AND DELEGATE

extension iPadCellVC : UICollectionViewDataSource{
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appData.count
    }
    
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let cellSize:CGSize = CGSize(width: 260, height: 90)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! IpadCellCollectionViewCell
        
        let data = appData[indexPath.row]
        print("index   \(indexPath.row)")
        let imgURL: NSURL = NSURL(string: data.value(forKey: "imageUrl") as! String)!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        
        cell.appTittle.text =  data.value(forKey: "name") as! String?
        let price = (data.value(forKey: "price") as! String?)!
        cell.appPrice.text = price == "0.00000" ? "Gratis" : price        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response, data, error) -> Void in
            
            if error == nil {
                cell.appImage.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
}

extension iPadCellVC : UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = appData[indexPath.row]
        
        let imgURL: NSURL = NSURL(string: data.value(forKey: "imageUrl") as! String)!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response, data, error) -> Void in
            if error == nil {
                let mydata = self.appData[indexPath.row]
                
                let details = iPadDetailVC.init(withdata: (mydata.value(forKey: "name") as! String?)!,
                                                price: (mydata.value(forKey: "price") as! String?)!,
                                                date: (mydata.value(forKey: "releaseDate") as! String?)!,
                                                category: (mydata.value(forKey: "category") as! String?)!,
                                                sumary: (mydata.value(forKey: "sumary") as! String?)!,
                                                image: UIImage(data: data!)!)
                details.transitioningDelegate = self.transition
                details.modalPresentationStyle = .custom
                self.present(details, animated: true, completion: nil)
            }
        }
        
        //ModelController.managerApp.insertEntry(obj)
        //let details = DetailsViewController()
        //self.navigationController?.pushViewController(details, animated: true)
    }
    
}
