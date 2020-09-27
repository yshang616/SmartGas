//
//  StationViewCellTableViewCell.swift
//  SmartGas
//
//  Created by 商语童 on 2020/9/28.
//

import UIKit

class StationViewCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
