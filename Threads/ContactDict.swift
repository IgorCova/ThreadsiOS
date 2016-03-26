//
//  ContactDict.swift
//  Threads
//
//  Created by Igor Cova on 20/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit
import Contacts

class ContactDict: UITableViewController {
    var contacts = [stContact]()
    let mContact = MemberContact()
    
    @IBOutlet weak var btnToMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.contacts = mContact.contactsByAlphabetDrawing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return contacts.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts[section].contacts.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return (section == 0) ? 0 : 20
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contact = contacts[indexPath.section].contacts[indexPath.row]
        
        for number in mContact.exceptionNumber {
            for lableOfNumber in contact.phoneNumbers {
                if number == mContact.stringNumber((lableOfNumber.value as! CNPhoneNumber).stringValue) {
                    let contactCell = tableView.dequeueReusableCellWithIdentifier("contactCell")! as! ContactCell
                    var decodedimage: UIImage?
                    var phoneNumber: String?
                    
                    if let image = contact.imageData {
                        decodedimage = UIImage(data: image)
                    }
                    
                    for numberLables in contact.phoneNumbers {
                        if numberLables.label == CNLabelPhoneNumberiPhone {
                            phoneNumber = (numberLables.value as! CNPhoneNumber).stringValue
                            break
                        }
                    }
                    
                    contactCell.setOriginalCell("\(contact.givenName) \(contact.familyName)", image: decodedimage, detail: phoneNumber ?? "")
                    return contactCell
                }
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contact")!
        cell.textLabel?.text = ("\(contact.givenName) \(contact.familyName)")
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contacts[section].letter
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
