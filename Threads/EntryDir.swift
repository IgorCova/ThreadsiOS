//
//  EntryDir.swift
//  Threads
//
//  Created by Jin-Mac on 18.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class EntryDir: UITableViewController {
    
    var communityID: Int = Int()
    
    @IBOutlet weak var tvEntry: UITableView!
    
    var dirEntry = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setEntryDir()
        self.tvEntry.delegate = self
        self.tvEntry.dataSource = self
        self.tvEntry.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setEntryDir() {
        let e1 = Entry(id: 1, communityName: "Ubuntu", columnName: "Post", redactorName: "Cova Igor", date: "18.10.2015 20:20", title: "TestimNormalno", likeText: "Beautiful", likes: 25)
        let e2 = Entry(id: 2, communityName: "Ubuntu", columnName: "Post", redactorName: "Cova Igor", date: "18.10.2015 20:05", title: "TestimNormalno", likeText: "Cova Like It", likes: 1)
        let e3 = Entry(id: 3, communityName: "Ubuntu", columnName: "Mett", redactorName: "Cova Igor", date: "14.10.2015 20:01", title: "TestimNormalno", likeText: "Fantastic", likes: 5)
        let e4 = Entry(id: 4, communityName: "Ubuntu", columnName: "Likes", redactorName: "Cova Igor", date: "13.10.2015 20:00", title: "TestimNormalno", likeText: "Incredible", likes: 100)
        let e5 = Entry(id: 5, communityName: "Ubuntu", columnName: "Post", redactorName: "Bubas Antony", date: "11.10.2015 19:54", title: "TestimNormalno", likeText: "Like", likes: 30)
        let e6 = Entry(id: 6, communityName: "Ubuntu", columnName: "Post", redactorName: "Djur Andrew", date: "10.10.2015 19:00", title: "TestimNormalno", likeText: "Great", likes: 12)
        let e7 = Entry(id: 7, communityName: "Ubuntu", columnName: "Likes", redactorName: "Cova Igor", date: "8.10.2015 20:050", title: "TestimNormalno", likeText: "Good", likes: 48)
        let e8 = Entry(id: 8, communityName: "Ubuntu", columnName: "Post", redactorName: "Bubas Antony", date: "8.10.2015 10:00", title: "TestimNormalno", likeText: "Like", likes: 14)
        let e9 = Entry(id: 9, communityName: "Ubuntu", columnName: "News", redactorName: "Djur Andrew", date: "5.10.2015 21:20", title: "TestimNormalno", likeText: "Go", likes: 5)
        
        dirEntry.append(e1)
        dirEntry.append(e2)
        dirEntry.append(e3)
        dirEntry.append(e4)
        dirEntry.append(e5)
        dirEntry.append(e6)
        dirEntry.append(e7)
        dirEntry.append(e8)
        dirEntry.append(e9)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dirEntry.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : EntryCell = (tableView.dequeueReusableCellWithIdentifier("EntryCell") as? EntryCell)!
        
        cell.setCell(dirEntry[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let communityDir = self.storyboard?.instantiateViewControllerWithIdentifier("CommunityDir") as! CommunityDir
        self.presentViewController(communityDir, animated: true, completion: nil)
        self.tvEntry.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    /*
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 150.0
    }
*/
    
}
