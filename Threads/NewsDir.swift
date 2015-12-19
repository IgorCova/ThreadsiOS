//
//  MyNewsDir.swift
//  Threads
//
//  Created by Igor Cova on 13/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class NewsDir: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIScrollViewDelegate {

    var dirNews = [Entry]()
    
    @IBOutlet weak var btnToMenu: UIBarButtonItem!
    @IBOutlet weak var tvNews: UITableView!
    var lastOffsetY : CGFloat = 0
    
    let navbar = UINavigationBar()
    var viewScrollIsDragging: Bool?
    var viewScrollIsDecelerating: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dirNews.isEmpty {
            self.dirNews = EntryData().getNews()
        }

        self.tvNews.delegate = self
        self.tvNews.dataSource = self
        self.tvNews.separatorStyle = .None
        
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        self.navigationController?.barHideOnSwipeGestureRecognizer.addTarget(self, action: "swipe:")

    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        self.navigationController?.hidesBarsOnSwipe = true
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tvNews.reloadData()
    }
    
    func swipe(sender: UIPanGestureRecognizer) {
        let isHidden = (self.navigationController?.navigationBar.frame.origin.y < 0)
        
        self.navigationController?.navigationBarHidden = isHidden
    }
    /*
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        self.lastOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView){
        let hide = scrollView.contentOffset.y > self.lastOffsetY
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
    }*/
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dirNews.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : EntryCell = (tableView.dequeueReusableCellWithIdentifier("NewsCell") as? EntryCell)!
        cell.setCell(dirNews[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let entry = dirNews[indexPath.row]
        let height : CGFloat = calculateHeightForString(entry.title)
        return height + 80.0
    }

}
