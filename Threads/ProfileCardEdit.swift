//
//  ProfileCardEdit.swift
//  Threads
//
//  Created by Igor Cova on 11/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ProfileCardEdit: UIViewController {

    @IBOutlet weak var txflUsername: UITextField!
    @IBOutlet weak var txflSurname: UITextField!
    @IBOutlet weak var txflName: UITextField!
    @IBOutlet weak var imgPhoto: UIImageView!
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.title = " "

        txflName.text = self.member?.name
        txflSurname.text = self.member?.surname
        txflUsername.text = self.member?.userName
        
        imgPhoto.imageFromUrl("\(MemberLogo)/\(MyMemberID).png")
        
        self.imgPhoto.layer.cornerRadius = self.imgPhoto.frame.size.height/2
        self.imgPhoto.layer.masksToBounds = true
        self.imgPhoto.layer.borderWidth = 0.1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveMember(sender: AnyObject) {
        
        self.member?.name = txflName.text!
        self.member?.surname = txflSurname.text!
        self.member?.userName = txflUsername.text!
        
        MemberData().wsMemberSave(member!) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
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
