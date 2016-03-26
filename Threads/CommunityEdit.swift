//
//  CommunityEditDict.swift
//  Threads
//
//  Created by Igor Cova on 07/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class CommunityEdit: UITableViewController {
    
    var commItems = [String]()
    var community: Community?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commItems = ["commNameCell","commViewCell",/*"commLinkCell",*/"commTaglineCell","commDescCell", "commTeamCell"]
        
        self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
            case "commTaglineCell":
            cell.setCell("Tagline", value: community?.tagline ?? "")
        default: break
        }
        return cell
    }
    
    @IBAction func save(sender: AnyObject) {
        if self.checkFields() {
            CommunityData().wsCommunitySave(community!) {id, successful in
                if successful {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
    }
    
    func checkFields() -> Bool {
        var checked = false
        var message = ""
        
        if (community?.name == "") {
            message = "Community Name is empty"
        }
        
        if message != "" {
            self.scrollToFirstRow()
            let pnlLab = UIView(frame: CGRect(x: 0, y: -60, width: 320, height: 60))
            pnlLab.backgroundColor = CommColor.colorWithAlphaComponent(0.75)
            
            let labelInfo = UILabel(frame: CGRect(x: 0, y: 20, width: 320, height: 20))
            labelInfo.text = message
            labelInfo.font = SFUIDisplayReg
            labelInfo.textColor = .whiteColor()
            labelInfo.textAlignment = .Center
            
            pnlLab.addSubview(labelInfo)
            view.addSubview(pnlLab)
            
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                pnlLab.center.y = 30
                
                }, completion: nil)
            
            UIView.animateWithDuration(0.2, delay: 3, options: .CurveLinear, animations: {
                pnlLab.center.y = -30
                
                }, completion: {(Bool) in
                    pnlLab.hidden = true
            })
        } else {
            checked = true
        }
        
        return checked
    }
    
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
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
        if (segue.identifier == "changeDesc") {
            let dvc = segue.destinationViewController as! DescCard
            dvc.comm = self.community
            dvc.isDesc = true
        } else if (segue.identifier == "changeTagline") {
            let dvc = segue.destinationViewController as! DescCard
            dvc.comm = self.community
            dvc.isDesc = false
        }
    }
}
