//
//  WelcomeCard.swift
//  Threads
//
//  Created by Igor Cova on 20/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class WelcomeCard: UIViewController {
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MemberData().wsGetMemberInstance(MyMemberID) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.member?.name = ""
                self.member?.about = ""
                self.member?.userName = ""
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editProfile" {
            if let vc = segue.destinationViewController as? ProfileCardEdit {
                vc.member = self.member
            }
        }

    }
    

}
