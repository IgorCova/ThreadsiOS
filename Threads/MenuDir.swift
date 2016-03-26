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
    
    var menuItems = [(cell: String?, name: String?, img: String?)]()
    var dirRefreshControl : UIRefreshControl!
    
    var member : Member?
    
    var contactStore = CNContactStore()
    var updateContact = CNContact()
    
    @IBOutlet var tvMenuItems: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.tvMenuItems.delegate = self
        self.tvMenuItems.dataSource = self
        
        self.menuItems = [(cell: "menuHeaderCell", name: "Профиль", img: "")
            ,(cell: "NewsCell", name: "News", img: "news")
            ,(cell: "CommCell", name: "Communities", img: "communities")
            ,(cell: "CommCell", name: "Suggested", img: "suggested")
            ,(cell: "BookmarkCell", name: "Bookmarks", img: "bookmarks")
            ,(cell: "CommCell", name: "Popular", img: "popular.png")
            ,(cell: "ContactsCell", name: "Contacts", img: "contacts")
            ,(cell: "SettingsCell", name: "Settings", img: "settings")
            ]
        
        self.dirRefreshControl = UIRefreshControl()
        self.dirRefreshControl.addTarget(self, action: #selector(MenuDir.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
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
            let profileCell = (tableView.dequeueReusableCellWithIdentifier("menuHeaderCell") as? MenuHeaderCell)!
            
            if self.member != nil {
                profileCell.setCell(self.member!)
            }
            
            return profileCell
        }
        
        let cellName = menuItems[indexPath.row].cell!
        let itemCell = (tableView.dequeueReusableCellWithIdentifier(cellName) as? MenuItemCell)!
        itemCell.imageView?.image = UIImage(named: menuItems[indexPath.row].img!)
        itemCell.textLabel?.text = menuItems[indexPath.row].name
        
        return itemCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        }
        return  50.0
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toComms" {
            let navController = segue.destinationViewController as! UINavigationController
            let comm = navController.viewControllers[0] as! CommunityDir
           comm.commDictType = .MyComm
        } else if segue.identifier == "toNews" {
            let navController = segue.destinationViewController as! UINavigationController
            let vc = navController.viewControllers[0] as! NewsDir
            vc.isNews = true
        }  else if segue.identifier == "toBookmarks" {
            let navController = segue.destinationViewController as! UINavigationController
            let vc = navController.viewControllers[0] as! NewsDir
            vc.isNews = false
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
