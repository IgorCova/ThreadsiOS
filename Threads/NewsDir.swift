//
//  MyNewsDir.swift
//  Threads
//
//  Created by Igor Cova on 13/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class NewsDir: UITableViewController {

    var dirNews = [Entry]()
    
    @IBOutlet weak var btnToMenu: UIBarButtonItem!
    @IBOutlet weak var tvNews: UITableView!
    
    var dirRefreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refresh(self)

        self.tvNews.delegate = self
        self.tvNews.dataSource = self
        self.tvNews.separatorStyle = .None
        
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.dirRefreshControl = UIRefreshControl()
        //self.dirRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.dirRefreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(dirRefreshControl!)
    }
    
    func refresh(sender:AnyObject) {
        NewsData().wsGetNewsReadByMemberID(MyMemberID) { arNews, successful in
            if successful {
                self.dirNews = arNews
                self.tvNews.reloadData()
                self.dirRefreshControl!.endRefreshing()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dirNews.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : EntryCell = (tableView.dequeueReusableCellWithIdentifier("NewsCell") as? EntryCell)!
        cell.setCell(dirNews[indexPath.row])
        
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let entry = dirNews[indexPath.row]
        let height : CGFloat = calculateHeightForString(entry.text)
        return height + 80.0
    }

}
