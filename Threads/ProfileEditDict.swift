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
    var timer = NSTimer()
    
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
        
        self.profileItems = ["nameCell","setPhotoCell","telegramCell","usernameCell","phoneCell","genderCell","ageCell","aboutCell","countryCell","cityCell"]
        self.tvProfile.reloadData()
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //view.addGestureRecognizer(tap)
    }
    
    /*
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    */
    
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
    
    override func viewWillAppear(animated: Bool) {
        self.tvProfile.reloadData()
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
                cell.setCell(m.userName ?? "username")
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
                cell.setCell(m)
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
    
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
    func checkFields() -> Bool {
        var checked = false
        var message = ""
        
        if (member?.name == "") {
            message = "First Name is empty"
        } else if (member?.surname ?? "" == "") {
            message = "Last Name is empty"
        }
        
        if message != "" {
            self.scrollToFirstRow()
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
    
    @IBAction func btnSave_Click(sender: AnyObject) {
        if checkFields() == true {
            MemberData().wsMemberSave(member!) {memberInstance, successful in
                if successful {
                    self.member = memberInstance
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
    }
    
    @IBAction func btnDone_Click(sender: AnyObject) {
        if checkFields() == true {
            MemberData().wsMemberSave(member!) {memberInstance, successful in
                if successful {
                    self.member = memberInstance
                    let Core = self.storyboard!.instantiateViewControllerWithIdentifier("Core") as! SWRevealViewController
                    self.presentViewController(Core, animated:true, completion:nil)
                }
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
        switch segue.identifier ?? "" {
        case "changeUsername":
            if let vc = segue.destinationViewController as? ChangeFieldCard {
                vc.member = self.member
                vc.isComm = true
            }
        case "changeTelegram":
            if let vc = segue.destinationViewController as? ChangeFieldCard {
                vc.member = self.member
                vc.isComm = false
            }
        case "toAbout":
            if let vc = segue.destinationViewController as? AboutCard {
                vc.member = self.member
            }
        default: break
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
        
        self.txflLastName.delegate = self
        self.txflFirstName.delegate = self
        
        self.txflLastName.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.txflFirstName.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
    }
    
    func textFieldDidChange(textField: UITextField) {
        switch textField {
        case txflFirstName:
            if let fn = textField.text {
                member?.name = fn
            }
        case txflLastName:
            if let sn = textField.text {
                member?.surname = sn
            }
        default: break
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(mem: Member) {
        self.member = mem
        self.imgLogo.imageFromUrl(memberLogoUrl(mem.id))
        self.txflFirstName.text = mem.name
        self.txflLastName.text = mem.surname ?? ""
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
    var member : Member?
    override func awakeFromNib() {
        super.awakeFromNib()
        scGender.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents: .TouchUpInside)
        scGender.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents: .ValueChanged)
    }
    
    func segmentedControlValueChanged (segment: UISegmentedControl) {
        member?.isMale = (segment.selectedSegmentIndex == 0)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(mem: Member) {
        self.member = mem
        
        if self.member!.isMale == true {
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
