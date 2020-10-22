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
    
    var html: String? = nil
    var stations: [Station] = []
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
    
//  The scraper function that sents a request to yellowpages and get a HTML content response
    func scrapeNYCMetalScene() -> Void {
        
        stationTableView.showAnimatedSkeleton()
        
        AF.request(requestURL, method: .get).responseString { response in
            debugPrint(response)
            
            self.html = response.value
            self.parseHTML(html: response.value!)
        }
        
    }
    
//  Parsing the HTML content into TableView content format
    func parseHTML(html: String) -> Void {
        if let doc =  try? Kanna.HTML(html: html, encoding: String.Encoding.utf8){
            stations = []
            
            // Search for nodes by XPath via a loop;
            for station in doc.css("div > div > div > div.info > h2 > a > span") {
                
                // Strip the string of surrounding whitespace;
                let showString = station.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
                
                // Set values for LOCATION info;
                let streetAddress =
                    station.parent?.parent?.nextSibling?.nextSibling?.at_css("div.street-address")?.text
                let locality = station.parent?.parent?.nextSibling?.nextSibling?.at_css(" div.locality")?.text
                
                var location = "N/A"
                // Combine street address with locality;
                if (streetAddress != nil) && locality != nil{
                    location = ("\(streetAddress!) \(locality!)")
                }
                
                // Set values for regular gas prices;
                let regularPrice = station.parent?.parent?.nextSibling?.nextSibling?.nextSibling?.at_xpath("div[1]/text()")?.text
    
                // Turn Str regularPrice into Int to allow price comparison.
                // Catch the nil errors with an if statement
                if regularPrice != nil {
                    let regularPriceNum = Int(regularPrice!.components(separatedBy:
                                                                        CharacterSet.decimalDigits.inverted).joined(separator: ""))
                    
                    stations.append(Station(location: location, description: showString, regularPrice: ("Regular Gas: \(regularPrice!)"), regularPriceInt: regularPriceNum!))
                    
                // If there is no price information, set price to very large number so
                // the gas station will be given less priority when sorting.
                } else {
                    stations.append(Station(location: location, description: showString, regularPrice: "N/A", regularPriceInt: 4000))
                }
            }
            
            //
            
            stations=stations.sorted(by: {$0.regularPriceInt<$1.regularPriceInt})
            
            self.stationTableView.reloadData()
            self.stationTableView.stopSkeletonAnimation()
            self.stationTableView.hideSkeleton()
            
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return textCellIdentifier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        let row = indexPath.row
        let station = stations[row]
        cell.detailTextLabel?.text = station.description+"\n"+station.location
        cell.textLabel?.text=station.regularPrice
        
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
        let station = stations[indexPath.row]
        DetailPageController().address = station.location
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is DetailPageController
        {
            let station = stations[stationTableView.indexPathForSelectedRow!.row]
            let vc = segue.destination as? DetailPageController
            vc?.address = station.location
            vc?.stationName = station.description
        }
    }
    
}



