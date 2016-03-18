//
//  ColumnsCell.swift
//  Threads
//
//  Created by Igor Cova on 17/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ColumnsCell: UITableViewCell {
    var community: Community?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(comm: Community) {
        self.community = comm
        
    }

}
