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
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgInMyList: UIImageView!
    @IBOutlet weak var plView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.imgLogoCom.layer.cornerRadius = self.imgLogoCom.frame.size.height/2
        self.imgLogoCom.layer.masksToBounds = true
        self.imgLogoCom.layer.borderWidth = 0.1
        self.imgInMyList.layer.cornerRadius = self.imgInMyList.frame.size.height/2

        
        //При добавлениии теней начинает все тормозить нужно будет потом что-то придумать
        self.plView.layer.masksToBounds = false
        self.plView.layer.shadowOffset = CGSizeMake(-2, 2)
        self.plView.layer.shadowRadius = 3
        self.plView.layer.shadowOpacity = 0.2
        
    }
    
    func setCell(com: Community) {
        self.imgLogoCom.image = UIImage(named: com.linkToImage)
        self.lblNameCom.text = com.name
        self.lblCategory.text = com.categoryName
        self.lblType.text = com.typeName
        self.imgInMyList.hidden = !com.inMyList
        
        if com.inMyList == true {
            self.joinButton.hidden = true
        } else {
            self.joinButton.hidden = false
            self.joinButton.layer.cornerRadius = 2
            //self.joinButton.layer.borderWidth = 2
            self.joinButton.tag = com.id
            //self.joinButton.layer.borderColor = UIColor(red: 144/220.0, green: 144/220.0, blue: 144/220.0, alpha: 1.0).CGColor
        }
    }
}

