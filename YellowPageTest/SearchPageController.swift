////
////  SearchPageController.swift
////  YellowPageTest
////
////  Created by 商语童 on 2020/10/12.
////
//
//import UIKit
//
//class SearchPageController: UIViewController {
//    
//    @IBOutlet var GasPriceSearch: UISearchBar!
//    var targetLocation: String = ""
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//            targetLocation = searchText
//        }
//
//        func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//            targetLocation = searchBar.text!
//            print(targetLocation)
//        }
//
//    
//
//  
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////         Get the new view controller using segue.destination.
////         Pass the selected object to the new view controller.
////        if segue.identifier == "Details" {
////                   let viewController:ViewController = segue!.destinationViewController as ViewController
////                   let indexPath = self.tableView.indexPathForSelectedRow()
////                   viewController.pinCode = self.exams[indexPath.row]
////    }
//
//
//}
////}
