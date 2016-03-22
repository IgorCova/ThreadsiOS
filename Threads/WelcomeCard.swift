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
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemberData().wsGetMemberInstance(MyMemberID) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "goToEditProfile", userInfo: nil, repeats: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goToEditProfile() {
        self.timer.invalidate()
        performSegueWithIdentifier("editProfile", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editProfile" {
            self.timer.invalidate()
            let navController = segue.destinationViewController as! UINavigationController
            if let vc = navController.viewControllers[0] as? ProfileEdit {
                vc.member = self.member
            }
        }
    }
}
