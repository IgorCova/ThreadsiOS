//
//  ProfileEditDict.swift
//  Threads
//
//  Created by Igor Cova on 27/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ProfileEdit: UITableViewController, UIPickerViewDelegate, UIAlertViewDelegate,  UINavigationControllerDelegate, UIImagePickerControllerDelegate, RSKImageCropViewControllerDelegate {

    var member: Member?
    var dirRefreshControl: UIRefreshControl?
    var profileItems = [String]()
    var ages = [Int]()
    var age = 18
    var pickerView = UIPickerView()
    var imgPhoto: UIImage?
    var timer = NSTimer()
    var datePickerHidden = true
    
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
        self.dirRefreshControl!.addTarget(self, action: #selector(ProfileEdit.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(dirRefreshControl!)
        
        self.profileItems = ["nameCell","setPhotoCell","telegramCell","usernameCell","phoneCell","genderCell","ageCell","birthdayCell","aboutCell","countryCell","cityCell"]
        self.tvProfile.reloadData()
        
        self.navigationController!.navigationBar.topItem!.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func refresh(sender:AnyObject) {
        MemberData().wsGetMemberInstance(MyMemberID) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.profileItems = ["nameCell","setPhotoCell","telegramCell","usernameCell","phoneCell","genderCell","ageCell","birthdayCell","aboutCell","countryCell","cityCell"]
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
            
             if let m = member {
                if let md = m.birthdayDate {
                    let age = NSDate().yearsFrom(md)
                    cell.setCell(age)
                }
            }
            return cell
        } else if self.profileItems[indexPath.row] == "birthdayCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(self.profileItems[indexPath.row], forIndexPath: indexPath) as! BirthdayCell
            if let m = member {
                cell.setCell(m)
            }
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
        } else if self.profileItems[indexPath.row] == "birthdayCell" {
            return self.datePickerHidden == false ? 216 : 0
        } else if self.profileItems[indexPath.row] == "aboutCell" {
            return 53.0
        } else if self.profileItems[indexPath.row] == "ageCell" {
            return 43.0
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
                
                }, completion: {(value: Bool) in
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
            self.toggleDatepicker()
        }
    }
    
    func toggleDatepicker() {
        self.datePickerHidden = !datePickerHidden
        let indexPath = NSIndexPath(forRow: 6, inSection: 0)
        self.tvProfile.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        
        self.tvProfile.beginUpdates()
        self.tvProfile.endUpdates()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier ?? "" {
        case "changeUsername":
            if let vc = segue.destinationViewController as? ChangeFieldCard {
                vc.member = self.member
                vc.typeL = .Comm
            }
        case "changeTelegram":
            if let vc = segue.destinationViewController as? ChangeFieldCard {
                vc.member = self.member
                vc.typeL = .Telegram
            }
        case "toAbout":
            if let vc = segue.destinationViewController as? AboutCard {
                vc.member = self.member
            }
        default: break
        }
    }
}