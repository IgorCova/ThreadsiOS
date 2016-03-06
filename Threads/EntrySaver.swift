//
//  EntryNew.swift
//  Threads
//
//  Created by Igor Cova on 01/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class EntrySaver: UIViewController , UITextViewDelegate {

    @IBOutlet weak var txtEntryText: UITextView!
    var communityId : Int?
    var columnId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.title = ""
        self.txtEntryText.delegate = self
        self.txtEntryText.selectAll(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveNewEntry(sender: AnyObject) {
        let entrytext = txtEntryText.text
        let newEntry = NewEntry(communityId: communityId!, columnId: columnId!, text: entrytext)
        
        EntryData().wsEntrySave(wsEntry: newEntry) {id, successful in
            if successful {
                self.navigationController?.popViewControllerAnimated(true)// dismissViewControllerAnimated(true, completion: nil)
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
