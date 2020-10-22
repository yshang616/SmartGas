//
//  ViewController.swift
//  KannaTest
//
//  Created by 商语童 on 2020/10/10.
//

import UIKit
import Kanna
import Alamofire
import MapKit
import SkeletonView

class ViewController: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource, UISearchBarDelegate {
    
    //    var targetLocation: String = ""
    var html: String? = nil
    var shows: [Station] = []
    var stationAddress: String? = ""
    
    let showConcertInfoSegueIdentifier = "ShowConcertInfoSegue"
    let textCellIdentifier = "stationCell"
    var targetLocation: String = ""
    var requestURL = "https://www.yellowpages.com/saintpaul-mn/gas-stations"
    
    
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet var stationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.tintColor = UIColor(named: "SmartOrange")
        navigationController?.navigationBar.barTintColor = UIColor(named: "SmartOrange")
        stationTableView.delegate = self
        stationTableView.dataSource = self
        SearchBar.delegate=self
        self.scrapeNYCMetalScene()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stationTableView.isSkeletonable = true
        
    }
    
    
    func scrapeNYCMetalScene() -> Void {
        
        stationTableView.showAnimatedSkeleton()
        
        AF.request(requestURL, method: .get).responseString { response in
            debugPrint(response)
            
            self.html = response.value
            self.parseHTML(html: response.value!)
        }
        
    }
    
    //    Parsing the HTML content into TableView content format
    func parseHTML(html: String) -> Void {
        if let doc =  try? Kanna.HTML(html: html, encoding: String.Encoding.utf8){
            shows = []
            
            // Search for nodes by XPath by a Loop
            for show in doc.css("div > div > div > div.info > h2 > a > span") {
                
                // Strip the string of surrounding whitespace.
                let showString = show.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
                
                // Set values for LOCATION info; Combine street address with locality
                let streetAddress =
                    show.parent?.parent?.nextSibling?.nextSibling?.at_css("div.street-address")?.text
                let locality = show.parent?.parent?.nextSibling?.nextSibling?.at_css(" div.locality")?.text
                
                var location = "N/A"
                
                if (streetAddress != nil) && locality != nil{
                    location = ("\(streetAddress!) \(locality!)")
                }
                
                // Set values for gas prices info;
                let regularPrice = show.parent?.parent?.nextSibling?.nextSibling?.nextSibling?.at_xpath("div[1]/text()")?.text
    
                
                if regularPrice != nil {
                    let regularPriceNum = Int(regularPrice!.components(separatedBy:
                                                                        CharacterSet.decimalDigits.inverted).joined(separator: ""))
                    
                    shows.append(Station(location: location, description: showString, regularPrice: ("Regular Gas: \(regularPrice!)"), regularPriceInt: regularPriceNum!))
                    
                } else {
                    shows.append(Station(location: location, description: showString, regularPrice: "N/A", regularPriceInt: 4000))
                }
                
            }
            shows=shows.sorted(by: {$0.regularPriceInt<$1.regularPriceInt})
            
            self.stationTableView.reloadData()
            self.stationTableView.stopSkeletonAnimation()
            self.stationTableView.hideSkeleton()
//            print(shows)
            
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return textCellIdentifier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        let row = indexPath.row
        let show = shows[row]
        cell.detailTextLabel?.text = show.description+"\n"+show.location
        cell.textLabel?.text=show.regularPrice
        
        return cell
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        targetLocation = SearchBar.text!
        targetLocation = targetLocation.replacingOccurrences(of: " ", with: "")
        requestURL = ("https://www.yellowpages.com/+\(targetLocation)+/gas-stations")
        print(targetLocation)
        print(requestURL)
        scrapeNYCMetalScene()
        self.stationTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let show = shows[indexPath.row]
        DetailPageController().address = show.location
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is DetailPageController
        {
            let show = shows[stationTableView.indexPathForSelectedRow!.row]
            let vc = segue.destination as? DetailPageController
            vc?.address = show.location
            vc?.stationName = show.description
        }
    }
    
}



