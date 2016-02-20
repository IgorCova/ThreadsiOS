//
//  SessionReqCard.swift
//  Threads
//
//  Created by Igor Cova on 13/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class SessionReqCard: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var bbiNext: UIBarButtonItem!
    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var txflPhone: UITextField!
    @IBOutlet weak var txflCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage();
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        txflPhone.delegate = self
        txflPhone.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField == txflPhone) {
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            let decimalString = components.joinWithSeparator("") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
            
            if txflCode.text != "" {
                bbiNext.enabled = length > 9
            }

            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if hasLeadingOne {
                formattedString.appendString("1 ")
                index += 1
            }
            
            if (length - index) > 3 {
                let areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@) ", areaCode)
                index += 3
            }
            
            if length - index > 3 {
                let prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            if length == 10 {
                let prefix = decimalString.substringWithRange(NSMakeRange(index, 2))
                formattedString.appendFormat("%@-", prefix)
                index += 2
            }

            let remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.text = formattedString as String
            return false
        } else {
            return true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nextStepSign" {
            if let vc = segue.destinationViewController as? SessionCard {
                let phonetext = "\(self.txflCode.text!) \(self.txflPhone.text!)"
                let phone = phonetext.removePunctMarks()
        
                SessionData().wsSessionReqSave(phone, completion: { (reqres, successful) -> Void in
                    if successful {
                        vc.phone = phonetext
                        vc.confirmCode = reqres.code
                        vc.sessionReqId = reqres.id
                        vc.memberId = reqres.memberId
                        //self.navigationController?.popViewControllerAnimated(true)// dismissViewControllerAnimated(true, completion: nil)
                    }
                })
            }
        }
    }
    
}
