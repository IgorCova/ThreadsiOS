//
//  ChangeFieldCard.swift
//  Threads
//
//  Created by Igor Cova on 28/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ChangeFieldCard: UIViewController {
    
    var username: String?
    
    @IBOutlet weak var txflUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txflUsername.text = username
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
