//
//  MenuDir.swift
//  Threads
//
//  Created by Igor Cova on 08/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class MenuDir: UITableViewController, CNContactPickerDelegate {
    
    var menuItems = [(cell: String?, name: String?, img: String?, imgS: String?)]() //= [(cell: "", name: "", img: ""), (cell: "", name: "", img: "")]
    var dirRefreshControl : UIRefreshControl!
    
    var member : Member?
    
    enum CommDictType {
        case MyComm
        case AllComm
        case SugComm
    }
    
    var contactStore = CNContactStore()
    var updateContact = CNContact()
    
    @IBOutlet var tvMenuItems: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.tvMenuItems.delegate = self
        self.tvMenuItems.dataSource = self
        
        self.menuItems = [(cell: "ProfileCell", name: "Профиль", img: "", imgS: "")
            ,(cell: "NewsCell", name: "News", img: "news.png", imgS: "newsSet.png")
            ,(cell: "CommCell", name: "Communities", img: "communities.png", imgS: "communitiesSet.png")
          //,(cell: "CommCell", name: "My Communities", img: "communities.png", imgS: "communitiesSet.png")
            ,(cell: "CommCell", name: "Suggested", img: "suggested.png", imgS: "suggestedSet.png")
            ,(cell: "CommCell", name: "Bookmarks", img: "bookmarks.png", imgS: "bookmarksSet.png")
            ,(cell: "CommCell", name: "Popular", img: "popular.png", imgS: "popularSet.png")
            ,(cell: "ContactsCell", name: "Contacts", img: "contacts.png", imgS: "contactsSet.png")
            ,(cell: "SettingsCell", name: "Settings", img: "settings.png", imgS: "settingsSet.png")
            ]
        
        self.dirRefreshControl = UIRefreshControl()
        self.dirRefreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        //self.tableView.addSubview(dirRefreshControl)
        self.refresh(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refresh(sender:AnyObject) {
        MemberData().wsGetMemberInstance(MyMemberID) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.tvMenuItems.reloadData()
                self.dirRefreshControl.endRefreshing()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh(self)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let profileCell = (tableView.dequeueReusableCellWithIdentifier("ProfileCell") as? ProfileCell)!
            
            if self.member != nil {
                profileCell.setCell(self.member!)
            }
            
            return profileCell
        }
        
        let cellName = menuItems[indexPath.row].cell!
        let itemCell = (tableView.dequeueReusableCellWithIdentifier(cellName) as? MenuItemCell)!
        itemCell.imageView?.image = UIImage(named: menuItems[indexPath.row].img!)
        itemCell.imageView?.highlightedImage = UIImage(named: menuItems[indexPath.row].imgS!)
        
        itemCell.textLabel?.text = menuItems[indexPath.row].name
        
        if menuItems[indexPath.row].name == "All Communities" {
            itemCell.tag = 0
        } else if menuItems[indexPath.row].name == "My Communities" {
            itemCell.tag = 1
        } else if menuItems[indexPath.row].name == "Suggested" {
            itemCell.tag = 2
        }
        
        return itemCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        }
        return  50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.menuItems[indexPath.row].cell == "ContactsCell" {
            let contactPickerViewController = CNContactPickerViewController()
            presentViewController(contactPickerViewController, animated: true, completion: nil)
        } else {
            self.revealViewController().setFrontViewPosition(FrontViewPosition.LeftSideMostRemoved, animated:  true)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toComms" {
            let navController = segue.destinationViewController as! UINavigationController
            let comm = navController.viewControllers[0] as! CommunityDir
            let cell : UITableViewCell = sender as! UITableViewCell
            
            if (cell.tag == 0) {
                comm.commDictType = .AllComm
            } else if (cell.tag == 1) {
                comm.commDictType = .MyComm
            } else if (cell.tag == 2) {
                comm.commDictType = .SugComm
            }
        }
    }
    
    func askForContactAccess() {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Denied, .NotDetermined:
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if !access {
                    if authorizationStatus == CNAuthorizationStatus.Denied {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            let alertController = UIAlertController(title: "Contacts", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                            }
                            
                            alertController.addAction(dismissAction)
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        })
                    }
                }
            })
            break
        default:
            break
        }
    }

}
