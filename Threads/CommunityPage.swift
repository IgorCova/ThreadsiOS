//
//  CommunityPage.swift
//  Threads
//
//  Created by Igor Cova on 22/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class CommunityPage: UITableViewController {
    var commItems = [String]()
    var community: Community?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commItems = ["commPageHeaderCell", "commPageTaglineCell", "commPageDescriptionCell"]
        self.title = self.community?.name ?? "Comm"
        
        self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.title = self.community?.name ?? "Comm"
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let comm = self.community!
        
        if commItems[indexPath.row] == "commPageHeaderCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(commItems[indexPath.row], forIndexPath: indexPath) as! CommPageHeaderCell
            cell.setCell(comm)
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(commItems[indexPath.row], forIndexPath: indexPath) as! CommPageItemCell
        
        switch commItems[indexPath.row] {
        case "commPageTaglineCell":
            cell.setCell("Tagline", value: comm.tagline ?? "")
        case "commPageDescriptionCell":
            cell.setCell("Description", value: comm.description ?? "")
        default: break
        }
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.commItems[indexPath.row] == "commPageHeaderCell" {
            return 115
        } else {
            return 80
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCommunityEdit" {
            if let vc = segue.destinationViewController as? CommunityEdit {
                vc.community = self.community
            }
        }
    }
}
