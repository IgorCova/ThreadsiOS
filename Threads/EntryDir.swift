//
//  EntryDir.swift
//  Threads
//
//  Created by Jin-Mac on 18.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class EntryDir: UITableViewController {
    var community : Community?
    var dirEntry = [Entry]()
    
    @IBOutlet weak var tvEntry: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dirEntry = EntryData().getEntriesByCommId((community?.id)!)
        
        self.tvEntry.delegate = self
        self.tvEntry.dataSource = self
        self.tvEntry.separatorStyle = .None
        self.title = community!.name
        
        self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
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
        return dirEntry.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let header = (tableView.dequeueReusableCellWithIdentifier("EntryHeaderCell") as? EntryHeaderCell)!
            header.userInteractionEnabled = false
            header.setCell(community!)
            
            return header
        }
        
        let cell : EntryCell = (tableView.dequeueReusableCellWithIdentifier("EntryCell") as? EntryCell)!        
        cell.setCell(dirEntry[indexPath.row])
        
        return cell
    }
   
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 101
        }
        
        let entry = dirEntry[indexPath.row]
        let height : CGFloat = calculateHeightForString(entry.title)
        return height + 80.0
    }
}
