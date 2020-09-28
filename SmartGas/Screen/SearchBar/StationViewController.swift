//
//  StationViewController.swift
//  SmartGas
//
//  Created by 商语童 on 2020/9/28.
//

import UIKit

class StationViewController: UIViewController {
    
    @IBOutlet weak var locationView: SearchView!
    var locationService: LocationService?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.didTapSearch = { [weak self] in print("search tapped")
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
