//
//  BaseView.swift
//  SmartGas
//
//  Created by 商语童 on 2020/9/28.
//

import UIKit

@IBDesignable class BaseView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func configure(){
        
    }
}
