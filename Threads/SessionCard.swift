//
//  SessionCard.swift
//  Threads
//
//  Created by Igor Cova on 14/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class SessionCard: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var txflCode: UITextField!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var bbiDone: UIBarButtonItem!
    
    var phone = ""
    var confirmCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPhone.text = phone
        navigationController?.navigationBar.shadowImage = UIImage();
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        txflCode.delegate = self
        txflCode.becomeFirstResponder()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        txflCode.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func bbiDoneClick(sender: AnyObject) {
        let Core = self.storyboard!.instantiateViewControllerWithIdentifier("Core") as! SWRevealViewController
        self.presentViewController(Core, animated:true, completion:nil)
    }
    
    func textFieldDidChange(textField: UITextField) {
        if (textField.text == confirmCode) {
            bbiDone.enabled = true
            bbiDoneClick(self)
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