//
//  CommMetricsCell.swift
//  Threads
//
//  Created by Igor Cova on 07/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class CommItemCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblItemName.sizeToFit()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(name: String, value: String) {
        self.lblItemName.text = name
        self.lblItemValue.text = value
    }
}
