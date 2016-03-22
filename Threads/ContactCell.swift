//
//  ContactCell.swift
//  Threads
//
//  Created by Igor Cova on 20/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var imgMember: UIImageView!
    @IBOutlet weak var lblMemberDetail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgMember.layer.cornerRadius = self.imgMember.frame.size.width / 2
        self.imgMember.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setOriginalCell(name: String, image: UIImage?, detail: String) {
        self.imgMember.image = image
        self.lblMemberDetail.text = detail
        self.lblName.text = name
    }
}
