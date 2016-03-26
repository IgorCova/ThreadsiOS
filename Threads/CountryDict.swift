//
//  CountryDict.swift
//  Threads
//
//  Created by Igor Cova on 13/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class CountryDict: UITableViewController {
    
    var dirCountry = [Country]()
    var dirRefreshControl : UIRefreshControl!
    
    @IBOutlet var tvCountries: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = .whiteColor()
        
        self.dirRefreshControl = UIRefreshControl()
        self.dirRefreshControl.addTarget(self, action: #selector(CountryDict.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(dirRefreshControl)
        self.dirRefreshControl?.beginRefreshing()
        self.refresh(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dirCountry.count
    }
    
    func refresh(sender:AnyObject) {
        CountryData().wsGetCountryReadDict({ (countryDict, successful) -> Void in
            if successful {
                self.dirCountry = countryDict
                self.tvCountries.reloadData()
                self.dirRefreshControl.endRefreshing()
            }
        })
    }
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CountryCell = tableView.dequeueReusableCellWithIdentifier("CountryCell", forIndexPath: indexPath) as! CountryCell

        cell.setCell(dirCountry[indexPath.row])

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
