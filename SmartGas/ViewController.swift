//
//  ViewController.swift
//  SmartGas
//
//  Created by 商语童 on 2020/9/27.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    var nameArray = [String]()
    let locManager = CLLocationManager()
    var lat:Double = 00.00
    var long:Double = 00.00
    
    //let myAPIKey = NearbyApi()
    

    
    @IBAction func bthShowClick(_ sender: Any) {
        self.printNames()
    }
    @IBOutlet weak var txtView: UITextView!
    
    func searchApiPlacesFromGoogle(){
        locManager.requestWhenInUseAuthorization()
        
        var current : CLLocation!
        current = locManager.location
        self.lat = current.coordinate.latitude
        self.long = current.coordinate.longitude
        
        print(self.lat)
        print(self.long)
        
        //use google map url which i will activate later
//        let stringGoogleApi = "http://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(self.lat),\(self.long)&radius=500&type=clinic&keyword=clinic&key=\(myAPIKey.enterYourAPIKeyHere)"
//        let url = NSURL(string: stringGoogleAPI)
//        URLSession.shared.dataTask(with: (url as URL?)!), completionHandler: { (data, response, error) -> Void in
//            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options:  .allowFragments) as? NSDictionary
//            {
//                if let gasArray = jsonObject.value(forKey: "results") as? NSArray{
//                for gas in gasArray{
//                        if let gasDict = gas as? NSDictionary{
//                            if let name = gasDict.value(forKey: "name"){
//                                self.nameArray.append(name as! String)
//                            }
//                        }
//                    }
//                }
//
//            }).resume()
//        }
    }
    func printNames() {
        self.txtView.text = nameArray.joined(separator: "\n \n")
    }
    
    
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchApiPlacesFromGoogle()
        
    }

}


//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//
//    @IBOutlet var tableView: UITableView!
//
//    let myData = ["gas1", "gas2", "gas3", "gas4", "gas5"]


//  Ignore these for now please!
//        tableView.delegate=self
//        tableView.dataSource=self
//    }
//  Ignore these for now please!
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myData.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
//                                                 for: indexPath)
//        cell.textLabel?.text=myData[indexPath.row]
//        return cell
//    }
