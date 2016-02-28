//
//  ProfileEditDict.swift
//  Threads
//
//  Created by Igor Cova on 27/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ProfileEditDict: UITableViewController, UIPickerViewDelegate, UIAlertViewDelegate {
    
    var member: Member?
    var dirRefreshControl: UIRefreshControl?
    var profileItems = [String]()
    var ages = [Int]()
    var age = 18
    var pickerView = UIPickerView()
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet var tvProfile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvProfile.delegate = self
        self.tvProfile.dataSource = self
        self.tvProfile.separatorStyle = .None
        self.navItem.backBarButtonItem?.title = ""
        self.navItem.leftBarButtonItem?.title = ""
        self.dirRefreshControl = UIRefreshControl()
        //self.dirRefreshControl!.attributedTitle = NSAttributedString(string: "Get current info About You")
        self.dirRefreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(dirRefreshControl!)
        self.refresh(self)
        
        for i in 1...125 {
            ages.append(i)
        }
        
        self.pickerView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refresh(sender:AnyObject) {
        MemberData().wsGetMemberInstance(MyMemberID) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.profileItems = ["nameCell","telegramCell","usernameCell","phoneCell","ageCell","genderCell","aboutCell","countryCell","cityCell"]
                self.tvProfile.reloadData()
                self.dirRefreshControl!.endRefreshing()
            } else {
                self.dirRefreshControl!.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profileItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.profileItems[indexPath.row] == "nameCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(self.profileItems[indexPath.row], forIndexPath: indexPath) as! NameCell
            
            if let m = member {
                cell.setCell(m)
            }
            return cell
        } else if self.profileItems[indexPath.row] == "usernameCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(self.profileItems[indexPath.row], forIndexPath: indexPath) as! UsernameCell
            
            if let m = member {
                cell.setCell(m.userName)
            }
            return cell
        } else if self.profileItems[indexPath.row] == "phoneCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(self.profileItems[indexPath.row], forIndexPath: indexPath) as! PhoneNumberCell
            
            if let m = member {
                cell.setCell(m.phone)
            }
            return cell
        } else if self.profileItems[indexPath.row] == "genderCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(self.profileItems[indexPath.row], forIndexPath: indexPath) as! GenderCell
            
            if let m = member {
                cell.setCell(m.isMale)
            }
            return cell
        } else if self.profileItems[indexPath.row] == "ageCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(self.profileItems[indexPath.row], forIndexPath: indexPath) as! AgeCell
            
            // if let m = member {
                cell.setCell(24)
            //}
            return cell
        }

        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.profileItems[indexPath.row], forIndexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.profileItems[indexPath.row] == "nameCell" {
            return 170.0
        } else {
            return 43.0
        }
        
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
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.ages.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.ages[row])"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.age = self.ages[row]
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.profileItems[indexPath.row] == "ageCell" {
            
            let alertView = UIAlertController(title: "How old are you?", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet);
            
            pickerView.frame = CGRectMake(15, 25, 270, 200)
            alertView.view.addSubview(self.pickerView)
            var action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertView.addAction(action)
            
            action = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertView.addAction(action)
            
            pickerView.selectRow(age-1, inComponent: 0, animated: true)
            presentViewController(alertView, animated: true, completion: nil)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "changeUsername" {
            if let vc = segue.destinationViewController as? ChangeFieldCard {
                vc.username = (self.member?.userName)!
            }
        }
    }
}

class NameCell: UITableViewCell {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblFirstName: UITextField!
    @IBOutlet weak var lblLastName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgLogo.layer.cornerRadius = self.imgLogo.frame.size.height/2
        self.imgLogo.layer.masksToBounds = true
        self.imgLogo.layer.borderWidth = 0.1
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(mem: Member) {
        self.imgLogo.imageFromUrl(memberLogoUrl(mem.id))
        self.lblFirstName.text = mem.name
        self.lblLastName.text = mem.surname
    }
}

class UsernameCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(userName: String) {
        self.lblUserName.text = "@\(userName)"
    }

}

class PhoneNumberCell: UITableViewCell {
    
    @IBOutlet weak var lblPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(phone: String) {
        self.lblPhone.text = "\(phone)"
    }
    
}

class GenderCell: UITableViewCell {
    
    @IBOutlet weak var scGender: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(isMale: Bool) {
        if isMale == true {
            self.scGender.selectedSegmentIndex = 0
        } else {
            self.scGender.selectedSegmentIndex = 1
        }
    }
    
}

class AgeCell: UITableViewCell {
    @IBOutlet weak var lblAges: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(age: Int) {
        self.lblAges.text = "\(age) years"
    }
    
}
