//
//  MenuDir.swift
//  Threads
//
//  Created by Igor Cova on 08/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class MenuDir: UITableViewController {
    
    var menuItems: [(cell: String?, name: String?, img: String?)] = [(cell: "", name: "", img: ""), (cell: "", name: "", img: "")]
    
    var member : Member?
    
    enum CommDictType {
        case MyComm
        case AllComm
        case SugComm
    }
    
    @IBOutlet var tvMenuItems: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        MemberData().wsGetMemberInstance(1) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.tvMenuItems.reloadData()
            }
        }
        
        self.tvMenuItems.delegate = self
        self.tvMenuItems.dataSource = self
        self.menuItems = [(cell: "ProfileCell", name: "Профиль", img: "")
            ,(cell: "NewsCell", name: "News", img: "News.png")
            ,(cell: "CommCell", name: "All community", img: "AllCommunities.png")
            ,(cell: "CommCell", name: "My community", img: "MyCommunities.png")
            ,(cell: "CommCell", name: "Suggested", img: "Suggested.png")
            ,(cell: "CommCell", name: "Bookmarks", img: "Bookmarks.png")
            ,(cell: "CommCell", name: "Popular", img: "Popular.png")
            ,(cell: "CommCell", name: "Control", img: "Control.png")
            ,(cell: "CommCell", name: "Settings", img: "Settings.png")
            ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
            
            profileCell.userInteractionEnabled = false
            return profileCell
        }
        
        let cellName = menuItems[indexPath.row].cell!
        let itemCell = (tableView.dequeueReusableCellWithIdentifier(cellName) as? MenuItemCell)!
        itemCell.imageView?.image = UIImage(named: menuItems[indexPath.row].img!)
        itemCell.textLabel?.text = menuItems[indexPath.row].name
        
        if menuItems[indexPath.row].name == "All community" {
            itemCell.tag = 0
        } else if menuItems[indexPath.row].name == "My community" {
            itemCell.tag = 1
        } else if menuItems[indexPath.row].name == "Suggested" {
            itemCell.tag = 2
        }
        
        return itemCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        }
        
        return  42.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.revealViewController().setFrontViewPosition(FrontViewPosition.LeftSideMostRemoved, animated:  true)
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
    

}
