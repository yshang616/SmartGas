//
//  ViewController.swift
//  SmartGas
//
//  Created by 商语童 on 2020/9/27.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    @IBOutlet var tableView: UITableView!
    
    let myData = ["gas1", "gas2", "gas3", "gas4", "gas5"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//  Ignore these for now please!
//        tableView.delegate=self
//        tableView.dataSource=self
    }
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

}

