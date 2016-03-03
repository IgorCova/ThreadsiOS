//
//  SettingsCard.swift
//  Threads
//
//  Created by Igor Cova on 27/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class SettingsCard: UIViewController {

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.btnMenu.target = self.revealViewController()
        self.btnMenu.action = Selector("revealToggle:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnLogout_Click(sender: AnyObject) {
        MemberData().deleteLog()
        
        let wc = self.storyboard!.instantiateViewControllerWithIdentifier("Start") as! StartCard
        self.presentViewController(wc, animated:true, completion:nil)
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
