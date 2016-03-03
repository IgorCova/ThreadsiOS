//
//  ProfileEditDict.swift
//  Threads
//
//  Created by Igor Cova on 27/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ProfileEditDict: UITableViewController, UIPickerViewDelegate, UIAlertViewDelegate,  UINavigationControllerDelegate, UIImagePickerControllerDelegate, RSKImageCropViewControllerDelegate {
    
    var member: Member?
    var dirRefreshControl: UIRefreshControl?
    var profileItems = [String]()
    var ages = [Int]()
    var age = 18
    var pickerView = UIPickerView()
    var imgPhoto: UIImage?
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet var tvProfile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvProfile.delegate = self
        self.tvProfile.dataSource = self
        self.tvProfile.separatorStyle = .None
        
        self.navItem.backBarButtonItem?.title = ""
        self.navItem.leftBarButtonItem?.title = ""
        
        for i in 1...125 {
            ages.append(i)
        }
        
        self.pickerView.delegate = self
        self.dirRefreshControl = UIRefreshControl()
        self.dirRefreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(dirRefreshControl!)
        self.dirRefreshControl?.beginRefreshing()
        self.refresh(self)
    }
    
    func refresh(sender:AnyObject) {
        MemberData().wsGetMemberInstance(MyMemberID) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.profileItems = ["nameCell","setPhotoCell","telegramCell","usernameCell","phoneCell","genderCell","ageCell","aboutCell","countryCell","cityCell"]
                self.tvProfile.reloadData()
                self.dirRefreshControl!.endRefreshing()
            } else {
                self.dirRefreshControl!.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            return 122.0
        } else if self.profileItems[indexPath.row] == "genderCell" {
            return 44.0
        } else if self.profileItems[indexPath.row] == "countryCell" {
            return 44.0
        } else if self.profileItems[indexPath.row] == "usernameCell" {
            return 44.0
        } else {
            return 48.0
        }
    }
    
    @IBAction func btnSave_Click(sender: AnyObject) {
        MemberData().wsMemberSave(member!) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
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
            let alertView = UIAlertController(title: "How old are you?", message: "\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet);
            
            pickerView.frame = CGRectMake(15, 25, 270, 200)
            alertView.view.addSubview(self.pickerView)
            var action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertView.addAction(action)
            
            action = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertView.addAction(action)
            
            pickerView.selectRow(age-1, inComponent: 0, animated: true)
            presentViewController(alertView, animated: true, completion: nil)
        }
        //else if self.profileItems[indexPath.row] == "setPhotoCell" {
        //  let wc = self.storyboard!.instantiateViewControllerWithIdentifier("PhotoLoaderCard") as! PhotoLoaderCard
        // self.presentViewController(wc, animated:true, completion:nil)
        // }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "changeUsername" {
            if let vc = segue.destinationViewController as? ChangeFieldCard {
                vc.username = (self.member?.userName)!
                vc.isComm = true
            }
        } else if segue.identifier == "changeTelegram" {
            if let vc = segue.destinationViewController as? ChangeFieldCard {
                vc.username = (self.member?.userName)!
                vc.isComm = false
            }
        }
    }
}

class NameCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txflFirstName: UITextField!
    @IBOutlet weak var txflLastName: UITextField!
    var member : Member?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgLogo.layer.cornerRadius = self.imgLogo.frame.size.height/2
        self.imgLogo.layer.masksToBounds = true
        self.imgLogo.layer.borderWidth = 0.1
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(mem: Member) {
        self.member = mem
        self.imgLogo.imageFromUrl(memberLogoUrl(mem.id))
        self.txflFirstName.text = mem.name
        self.txflLastName.text = mem.surname
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == txflFirstName {
            if let fn = self.txflFirstName.text {
                member?.name = fn
            }
        } else if textField == txflLastName {
            if let sn = self.txflLastName.text {
                member?.surname = sn
            }
        }
    }
}

class UsernameCell: UITableViewCell {
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
