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
        
        self.tvNews.delegate = self
        self.tvNews.dataSource = self
        self.tvNews.separatorStyle = .None
        
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(
            self.revealViewController().panGestureRecognizer())
        
        self.dirRefreshControl = UIRefreshControl()
        self.dirRefreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(dirRefreshControl!)
        self.dirRefreshControl?.beginRefreshing()
        self.refresh(self)
    }
    
    func refresh(sender:AnyObject) {
        NewsData().wsGetNewsReadByMemberID(MyMemberID) { arNews, successful in
            if successful {
                self.dirNews = arNews
                self.tvNews.reloadData()
                self.dirRefreshControl!.endRefreshing()
                self.check()
            } else {
                self.dirRefreshControl!.endRefreshing()
                self.check()
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
        let height : CGFloat = entry.text.heightWithConstrainedWidth(310, font: CommFontText!)// calculateHeightForString(entry.text)
        return height + 80.0
    }
    
    func check() -> Bool {
        var checked = false
        var message = ""
        
        if (dirNews.count == 0) {
            message = "You don't have any news"
        }
        
        if message != "" {
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
                
                }, completion: {(value Bool) in
                    pnlLab.hidden = true
            })
        } else {
            checked = true
        }
        
        return checked
    }


}
