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

    // MARK: - Table view data source

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
        if (segue.identifier == "ShowCommunityEntrys") {        
            let entry = segue.destinationViewController as! EntryDir
            entry.community.removeAll()
            entry.community.append(dirCommunity[(tvCommunity.indexPathForSelectedRow?.row)!])
        }
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentCommunityID = dirCommunity[indexPath.row].id
        
        /*let entryDir = self.storyboard?.instantiateViewControllerWithIdentifier("EntryDir") as! EntryDir
        self.presentViewController(entryDir, animated: true, completion: nil)
        self.tvCommunity.deselectRowAtIndexPath(indexPath, animated: true)*/
    }
*/
  /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        code
    }*/
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

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}