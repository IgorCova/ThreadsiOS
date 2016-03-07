//
//  AgeCell.swift
//  Threads
//
//  Created by Igor Cova on 07/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class AgeCell: UITableViewCell {
    @IBOutlet weak var lblAges: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(age: Int) {
        self.lblAges.text = "\(age) years"
    }
}

