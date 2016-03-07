//
//  CommunityEditDict.swift
//  Threads
//
//  Created by Igor Cova on 07/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class CommunityEditDict: UITableViewController {
    
    var commItems = [String]()
    var community: Community?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commItems = ["commNameCell","commViewCell","commLinkCell","commStatusCell","commDescCell", "commTeamCell"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commItems.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.commItems[indexPath.row] == "commNameCell" {
            return 115
        } else {
            return 48
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if commItems[indexPath.row] == "commNameCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(commItems[indexPath.row], forIndexPath: indexPath) as! CommNameCell
            cell.setCell(self.community!)
            
            return cell
        } 
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(commItems[indexPath.row], forIndexPath: indexPath) as! CommItemCell
        
        switch commItems[indexPath.row] {
            case "commDescCell":
            cell.setCell("Description", value: community?.description ?? "")
        case "commLinkCell":
            cell.setCell("Link", value: "@comm_\(community?.link ?? "")")
        case "commTeamCell":
            cell.setCell("Team", value: "\(community?.countMembers ?? "0") members")
        default: break
        }
        return cell
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
