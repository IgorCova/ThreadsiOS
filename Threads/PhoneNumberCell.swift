//
//  PhoneNumberCell.swift
//  Threads
//
//  Created by Igor Cova on 07/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class PhoneNumberCell: UITableViewCell {
    
    @IBOutlet weak var lblPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(phone: String) {
        self.lblPhone.text = "\(phone)"
    }
}