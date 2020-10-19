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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //defining destination
    @IBAction func directInMap(_ sender: Any) {
        let latitude:CLLocationDegrees = 44.945746
        let longitude:CLLocationDegrees = 93.107697
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        
        let regionSpan = MKCoordinateRegion(center: coordinates,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "gas station"
        mapItem.openInMaps(launchOptions: options)
    }
    
    
//    var targetLocation: String = ""
    var html: String? = nil
    
    var shows: [Station] = []
    
    let showConcertInfoSegueIdentifier = "ShowConcertInfoSegue"
    let textCellIdentifier = "ShowCell"
    var targetLocation: String = ""
    var requestURL = "https://www.yellowpages.com/saintpaul-mn/gas-stations"
    
  
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet var metalShowTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        metalShowTableView.delegate = self
        metalShowTableView.dataSource = self
        SearchBar.delegate=self
        self.scrapeNYCMetalScene()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrapeNYCMetalScene() -> Void {
       
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
                    
                    shows.append(Station(location: location, description: showString, venue: ("Regular Gas: \(regularPrice!)"), link: "", price: regularPriceNum!))
                    
//                    thumbNailImg = stationImg as! UIImage
                    
                    
                } else {
                    shows.append(Station(location: location, description: showString, venue: "N/A", link: "", price: 4000))
                }
                

            }
            shows=shows.sorted(by: {$0.price<$1.price
            })
            
            self.metalShowTableView.reloadData()
            print(shows)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        let row = indexPath.row
        let show = shows[row]
        cell.detailTextLabel?.text = show.description+"\n"+show.location
        cell.textLabel?.text=show.venue

        return cell
    }
    
    
//    Search Bar Config

    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        targetLocation = searchText
//        print(searchText)
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        targetLocation = SearchBar.text!
        targetLocation = targetLocation.replacingOccurrences(of: " ", with: "")
        requestURL = ("https://www.yellowpages.com/+\(targetLocation)+/gas-stations")
        print(targetLocation)
        print(requestURL)
        scrapeNYCMetalScene()
        self.metalShowTableView.reloadData()
    }
 
}



