//
//  CommunityCell.swift
//  Threads
//
//  Created by Jin-Mac on 04.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class CommunityCell: UITableViewCell {

    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var imgLogoCom: UIImageView!
    @IBOutlet weak var lblNameCom: UILabel!
    @IBOutlet weak var plView: UIView!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblCountMembers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.imgLogoCom.layer.cornerRadius = self.imgLogoCom.frame.size.height/2
        self.imgLogoCom.layer.masksToBounds = true
        //self.imgLogoCom.layer.borderWidth = 0.1
        self.joinButton.layer.cornerRadius = 2
        /*//При добавлениии теней начинает все тормозить нужно будет потом что-то придумать
        self.plView.layer.masksToBounds = false
        self.plView.layer.shadowOffset = CGSizeMake(-2, 2)
        self.plView.layer.shadowRadius = 3
        self.plView.layer.shadowOpacity = 0.2*/
    }
    
    func setCell(com: Community) {
        self.imgLogoCom.imageFromUrl(com.linkToImage)
        self.lblNameCom.text = com.name
        self.lblCountMembers.text = com.countMembers + " members"
        if com.isMember == true {
            self.joinButton.hidden = true
            self.lblRole.text = "I'm member"
        } else {
            self.joinButton.hidden = false
            self.lblRole.text = "Outsider"
        }
    }
}

