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
    @IBOutlet weak var btnLeave: UIButton!
    @IBOutlet weak var plView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.imgCommunity.layer.cornerRadius = self.imgCommunity.frame.size.height/2
        self.imgCommunity.layer.masksToBounds = true
        self.imgCommunity.layer.borderWidth = 0.1
        
        self.btnLeave.layer.cornerRadius = 2
        
        /*//При добавлениии теней начинает все тормозить нужно будет потом что-то придумать
        self.plView.layer.masksToBounds = false
        self.plView.layer.shadowOffset = CGSizeMake(-2, 2)
        self.plView.layer.shadowRadius = 3
        self.plView.layer.shadowOpacity = 0.2*/
    }
    
    func setCell(com: Community) {
        self.lblCommunityName.text = com.name
        self.lblRoleInCommunity.text = "I'm owner"
        self.imgCommunity.imageFromUrl(com.linkToImage)
    }

}
