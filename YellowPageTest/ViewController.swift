//
//  ViewController.swift
//  KannaTest
//
//  Created by 商语童 on 2020/10/10.
//

import UIKit
import Kanna
import Alamofire


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var html: String? = nil
    var shows: [Station] = []
    
    let showConcertInfoSegueIdentifier = "ShowConcertInfoSegue"
    let textCellIdentifier = "ShowCell"
    
    @IBOutlet var metalShowTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        metalShowTableView.delegate = self
        metalShowTableView.dataSource = self
        self.scrapeNYCMetalScene()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrapeNYCMetalScene() -> Void {
        AF.request("https://www.yellowpages.com/sacramento-ca/gas-stations", method: .get).responseString { response in
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
                let location = ("\(streetAddress!) \(locality!)")
                
                // Set values for gas prices info;
                
                let regularPrice = show.parent?.parent?.nextSibling?.nextSibling?.nextSibling?.at_xpath("div[1]/text()")?.text
                
                if regularPrice != nil {
                    shows.append(Station(location: location, description: showString, venue: ("Regular Gas: \(regularPrice!)"), link: ""))
                } else {
                    shows.append(Station(location: location, description: showString, venue: "N/A", link: ""))
                }
                
                //                    }
                //                }
            }
            
            
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
        
        cell.detailTextLabel?.text = show.location + "\n" + show.venue
        cell.textLabel?.text = show.description
        
        return cell
    }
}



