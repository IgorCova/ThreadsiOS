//
//  CommunityDir.swift
//  Threads
//
//  Created by Jin-Mac on 04.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

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
    
    var dirCommunity = [Community]()
    var currentCommunityID : Int!
    var isOnlyMyCommunities : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.setCommunityDir()
        self.tvCommunity.delegate = self
        self.tvCommunity.dataSource = self
        self.tvCommunity.separatorStyle = .None
        
        self.tvCommunity.backgroundColor = UIColor(netHex: 0xE8E8E8)
        self.tvCommunity.backgroundView = nil
        self.tvCommunity.backgroundView = UIView()
        self.tvCommunity.backgroundView?.backgroundColor = UIColor(netHex: 0xE8E8E8)
        
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = Selector("revealToggle:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dirCommunity.count
    }
    
    func setCommunityDir() {
        
        let c1 = Community(id: 1, name: "Digital Tectonics", linkToImage: "ComLogos/DigTec.jpg", inMyList: true, countMembers: "1145")
        let c2 = Community(id: 2, name: "Major Mafia", linkToImage: "ComLogos/MajorMafia.png", inMyList: true, countMembers: "214")
        let c3 = Community(id: 3, name: "mr Freeman", linkToImage: "ComLogos/mF.png", inMyList: true, countMembers: "1098")
        let c4 = Community(id: 4, name: "Run Foundation", linkToImage: "ComLogos/RunFoundation.png", inMyList: false, countMembers: "310")
        let c5 = Community(id: 5, name: "Threads", linkToImage: "ComLogos/thread.png", inMyList: false, countMembers: "18017")
        
        if (commDictType != .SugComm) {
            dirCommunity.append(c1)
            dirCommunity.append(c2)
            dirCommunity.append(c3)
        }
        
        if (commDictType == .AllComm) || (commDictType == .SugComm) {
            dirCommunity.append(c4)
            dirCommunity.append(c5)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CommunityCell = (tableView.dequeueReusableCellWithIdentifier("CommunityCell") as? CommunityCell)!
        cell.setCell(dirCommunity[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if dirCommunity[indexPath.row].inMyList == false {
            return 128.0
        }
        
        return 98.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowCommunityEntries") {        
            let entry = segue.destinationViewController as! EntryDir
            entry.community = dirCommunity[(tvCommunity.indexPathForSelectedRow?.row)!]
        }
    }
}

