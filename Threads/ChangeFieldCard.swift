//
//  ChangeFieldCard.swift
//  Threads
//
//  Created by Igor Cova on 28/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ChangeFieldCard: UIViewController {
    
    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var lblInstruction: UILabel!
    var username: String?
    var isComm = true
    
    @IBOutlet weak var txflUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txflUsername.text = self.username
       
        if isComm == false {
            self.lblLink.text = "https://telegram.me/\(self.username)"
            self.title = "Telegram"
            self.lblInstruction.text =
            "You can set a username from Telegram. If you do, other people will be able to contact with you at Comm. \n\n You must confirm your Telegram profile. \n On this link our bot:"
        } else {
            self.lblLink.text = "https://commhub.org/\(self.username!)"
            self.title = "Comm"
            self.lblInstruction.text =
            "You can choose a username on Comm. If you do, other people will be able to find you by this username and contact you without knowing your phone number. \n\nYou can use a-z, 0-9 and underscores. Minimum length is 4 characters. \n\nThis link opens a chat with you in Comm:"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func btnSave_Click(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func btnCansel_Click(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
