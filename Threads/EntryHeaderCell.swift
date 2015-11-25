//
//  EntryHeaderCell.swift
//  Threads
//
//  Created by Admin on 26.11.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class EntryHeaderCell: UITableViewCell {
    @IBOutlet weak var imgCommunity: UIImageView!
    @IBOutlet weak var lblRoleInCommunity: UILabel!
    @IBOutlet weak var lblCommunityName: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.imgCommunity.layer.cornerRadius = self.imgCommunity.frame.size.height/2
        self.imgCommunity.layer.masksToBounds = true
        self.imgCommunity.layer.borderWidth = 0.1
    }
    
    func setCell(com: Community) {
        self.lblCommunityName.text = com.name
        self.lblRoleInCommunity.text = "I'm owner"
        self.imgCommunity.image = UIImage(named: com.linkToImage)
    }

}
