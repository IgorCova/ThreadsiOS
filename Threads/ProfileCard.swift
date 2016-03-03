//
//  ProfileCard.swift
//  Threads
//
//  Created by Igor Cova on 11/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ProfileCard: UIViewController {

    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblSurname: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnToMenu: UIBarButtonItem!
    @IBOutlet weak var txtAbout: UITextView!
    
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MemberData().wsGetMemberInstance(MyMemberID) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                
                self.lblName.text = self.member!.name
                
                self.lblSurname.text = self.member?.surname
                
                self.txtAbout.text = self.member?.about
                
                self.imgPhoto.imageFromUrl("\(MemberLogo)/\(MyMemberID).png")
                
                self.title = "\(self.member!.name) \(self.member!.surname)"
            }
        }
        
        self.imgPhoto.layer.cornerRadius = self.imgPhoto.frame.size.height/2
        self.imgPhoto.layer.masksToBounds = true
        self.imgPhoto.layer.borderWidth = 0.1
        
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = Selector("revealToggle:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    //}
}
