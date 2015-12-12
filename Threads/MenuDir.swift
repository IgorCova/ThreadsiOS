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
   
    enum CommDictType {
        case MyComm
        case AllComm
        case SugComm
    }
    
    @IBOutlet var tvMenuItems: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvMenuItems.delegate = self
        self.tvMenuItems.dataSource = self
        
        /*
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
        }*/
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        /*self.menuItems = [(cell: "ProfileCell", name: "Профиль", img: "")
                         ,(cell: "NewsCell", name: "News", img: "News.png")
                         ,(cell: "AllCommCell", name: "All community", img: "AllCommunities.png")
                         ,(cell: "MyCommCell", name: "My community", img: "MyCommunities.png")
                         ,(cell: "SgCommCell", name: "Suggested", img: "Suggested.png")], "Bookmarks", "Popular", "Control", "Settings"]*/
        
        
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
        
        //, "Bookmarks", "Popular", "Control", "Settings"]
        //self.menuItems = ["ProfileCell", "NewsCell", "AllCommCell"]//,"MyCommCell", "SgCommCell", "BookmarksCell", "PopularCell", "ControlCell", "SettingsCell"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let profileCell = (tableView.dequeueReusableCellWithIdentifier("ProfileCell") as? ProfileCell)!
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
