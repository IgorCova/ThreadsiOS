//
//  ProfileCardEdit.swift
//  Threads
//
//  Created by Igor Cova on 11/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ProfileCardEdit: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txflUsername: UITextField!
    @IBOutlet weak var txflSurname: UITextField!
    @IBOutlet weak var txflName: UITextField!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var txtAbout: UITextView!
    
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.title = " "
        
        MemberData().wsGetMemberInstance(MyMemberID) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.txflName.text = memberInstance!.name
                self.txflSurname.text = memberInstance!.surname
                self.txflUsername.text = memberInstance!.userName
                self.txtAbout.text = memberInstance!.about
            } else {
                self.txflName.text = self.member!.name
                self.txflSurname.text = self.member!.surname
                self.txflUsername.text = self.member!.userName
                self.txtAbout.text = self.member!.about
            }
        }
        
        imgPhoto.imageFromUrl("\(MemberLogo)/\(MyMemberID).png")
        self.imgPhoto.layer.cornerRadius = self.imgPhoto.frame.size.height/2
        self.imgPhoto.layer.masksToBounds = true
        self.imgPhoto.layer.borderWidth = 0.1
        
        self.txflName.delegate = self
        self.txflName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func doneEdit(sender: AnyObject) {
        self.member?.name = txflName.text!
        self.member?.surname = txflSurname.text!
        self.member?.userName = txflUsername.text!
        self.member?.about = txtAbout.text
            
        MemberData().wsMemberSave(member!) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                let Core = self.storyboard!.instantiateViewControllerWithIdentifier("Core") as! SWRevealViewController
                self.presentViewController(Core, animated:true, completion:nil)
            }
        }
    }

    @IBAction func saveMember(sender: AnyObject) {
        self.member?.name = txflName.text!
        self.member?.surname = txflSurname.text!
        self.member?.userName = txflUsername.text!
        self.member?.about = txtAbout.text

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
