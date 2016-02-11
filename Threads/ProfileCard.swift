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
    override func viewDidLoad() {
        super.viewDidLoad()
                
        lblName.text = "Igor"
        lblSurname.text = "Cova"
        txtAbout.text = "I'm no superman"
        imgPhoto.imageFromUrl("\(MemberLogo)/\(MyMemberID).png")
        self.title = "Igor_Cova"
        
        self.imgPhoto.layer.cornerRadius = self.imgPhoto.frame.size.height/2
        self.imgPhoto.layer.masksToBounds = true
        self.imgPhoto.layer.borderWidth = 0.1
        
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = Selector("revealToggle:")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
