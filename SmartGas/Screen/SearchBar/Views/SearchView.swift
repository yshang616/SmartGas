//
//  SearchView.swift
//  SmartGas
//
//  Created by 商语童 on 2020/9/28.
//

import UIKit

class SearchView: BaseView {

    @IBOutlet weak var searchNearMe: UIButton!
    
    var didTapSearch: (()->Void)?
    
    @IBAction func allowAction(_ sender:UIButton){
        didTapSearch?()
    }
    
    @IBAction func denyAction(_ sender:UIButton){
        
    }

}