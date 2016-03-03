//
//  CommunityDir.swift
//  Threads
//
//  Created by Jin-Mac on 04.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommunityDir: UITableViewController {
    
    @IBOutlet weak var itmMenu: UIBarButtonItem!
    @IBOutlet var tvCommunity: UITableView!
    @IBOutlet weak var btnToMenu: UIBarButtonItem!
    
    enum CommDictType {
        case MyComm
        case AllComm
        case SugComm
    }
    
    var commDictType = CommDictType.AllComm
    
    var dirRefreshControl : UIRefreshControl!
    
    var dirCommunity = [Community]()
    
    var currentCommunityID : Int!
    var isOnlyMyCommunities : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        self.tvCommunity.delegate = self
        self.tvCommunity.dataSource = self
        self.tvCommunity.separatorStyle = .None
        self.tvCommunity.backgroundColor = UIColor(netHex: 0xE8E8E8)
        self.tvCommunity.backgroundView = nil
        self.tvCommunity.backgroundView = UIView()
        self.tvCommunity.backgroundView?.backgroundColor = UIColor(netHex: 0xE8E8E8)
        
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = Selector("revealToggle:")
        
        self.dirRefreshControl = UIRefreshControl()
        self.dirRefreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(dirRefreshControl)
        self.dirRefreshControl?.beginRefreshing()
        self.refresh(self)
    }
    
    func refresh(sender:AnyObject) {
        if commDictType == .AllComm {
            CommunityData().wsGetCommunityDict(MyMemberID) {communityDict, successful in
                if successful {
                    self.dirCommunity = communityDict
                    self.tvCommunity.reloadData()
                    self.dirRefreshControl.endRefreshing()
                }
            }
        } else if commDictType == .MyComm {
            CommunityData().wsGetCommunityMyDict(MyMemberID) {communityDict, successful in
                if successful {
                    self.dirCommunity = communityDict
                    self.tvCommunity.reloadData()
                    self.dirRefreshControl.endRefreshing()
                }
            }
            
        } else if commDictType == .SugComm {
            CommunityData().wsGetCommunitySuggestDict(MyMemberID) {communityDict, successful in
                if successful {
                    self.dirCommunity = communityDict
                    self.tvCommunity.reloadData()
                    self.dirRefreshControl.endRefreshing()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dirCommunity.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CommunityCell = (tableView.dequeueReusableCellWithIdentifier("CommunityCell") as? CommunityCell)!
        cell.setCell(dirCommunity[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if dirCommunity[indexPath.row].isMember == false {
            return 132.0
        }
        
        return 105.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowCommunityEntries") {        
            let entry = segue.destinationViewController as! EntryDir
            entry.community = dirCommunity[(tvCommunity.indexPathForSelectedRow?.row)!]
        }
    }
}

