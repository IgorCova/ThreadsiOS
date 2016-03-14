//
//  NameCell.swift
//  Threads
//
//  Created by Igor Cova on 07/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txflFirstName: UITextField!
    @IBOutlet weak var txflLastName: UITextField!
    var member : Member?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgLogo.layer.cornerRadius = self.imgLogo.frame.size.height/2
        self.imgLogo.layer.masksToBounds = true
        self.imgLogo.layer.borderWidth = 0.1
        
        self.txflLastName.delegate = self
        self.txflFirstName.delegate = self
        
        self.txflLastName.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.txflFirstName.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
    }
    
    func textFieldDidChange(textField: UITextField) {
        switch textField {
        case txflFirstName:
            if let fn = textField.text {
                member?.name = fn
            }
        case txflLastName:
            if let sn = textField.text {
                member?.surname = sn
            }
        default: break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(mem: Member) {
        self.member = mem
        self.imgLogo.imageFromUrl(memberLogoUrl(mem.id))
        self.txflFirstName.text = mem.name
        self.txflLastName.text = mem.surname ?? ""
    }
}
