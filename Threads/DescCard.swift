//
//  DescCard.swift
//  Threads
//
//  Created by Igor Cova on 13/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class DescCard: UIViewController, UITextViewDelegate {

    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var txvDesc: UITextView!
    var isDesc = true
    var comm : Community?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txvDesc.selectAll(self)
        
        if isDesc == true {
            self.txvDesc.text = comm?.description ?? ""
            self.title = "Description"
            self.lbDesc.text = "Please describe community in \na few words [1024 characters]"
        } else {
          self.txvDesc.text = comm?.tagline ?? ""
          self.title = "Tagline"
          self.lbDesc.text = "Add tagline this community in a few words [64 characters]"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        if let text = self.txvDesc.text {
            if isDesc == true {
                comm?.description = text
            } else {
                comm?.tagline = text
            }
        }
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
