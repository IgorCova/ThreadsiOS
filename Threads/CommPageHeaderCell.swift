//
//  CommunityPageNameCell.swift
//  Threads
//
//  Created by Igor Cova on 22/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class CommPageHeaderCell: UITableViewCell {

    @IBOutlet weak var lblCommView: UILabel!
    @IBOutlet weak var lblCommName: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    
    var community: Community?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgLogo.layer.cornerRadius = self.imgLogo.frame.size.height/2
        self.imgLogo.layer.masksToBounds = true
        self.imgLogo.layer.borderWidth = 0.7
        self.imgLogo.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(comm: Community) {
        self.community = comm
        if let cm = community {
            self.lblCommName.text = cm.name
            self.lblCommView.text = "Public"
            self.imgLogo.imageFromUrl(cm.linkToImage)
        }
    }

}
