//
//  CommNameCell.swift
//  Threads
//
//  Created by Igor Cova on 07/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class CommNameCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var txflCommName: UITextField!
    @IBOutlet weak var imgLogo: UIImageView!
    
    var community: Community?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgLogo.layer.cornerRadius = self.imgLogo.frame.size.height/2
        self.imgLogo.layer.masksToBounds = true
        self.imgLogo.layer.borderWidth = 0.7
        self.imgLogo.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.txflCommName.delegate = self
        self.txflCommName.addTarget(self, action: "textFieldDidChange:", forControlEvents: .EditingChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(comm: Community) {
        self.community = comm
        if let cm = community {
            self.txflCommName.text = cm.name
            self.imgLogo.imageFromUrl(cm.linkToImage)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }

    func textFieldDidChange(textField: UITextField) {
        switch textField {
        case txflCommName:
            if let fn = textField.text {
                community?.name = fn
            }
        default: break
        }
    }
    
}
