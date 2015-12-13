//
//  ProfileCell.swift
//  Threads
//
//  Created by Igor Cova on 09/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblPersonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2
        self.imgProfile.layer.masksToBounds = true
        self.imgProfile.layer.borderWidth = 0.1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.imgProfile.image = UIImage(named: "ComLogos/CovaImg.png")
        self.lblPersonName.text = "Cova Igor"
    }

}
