//
//  BirthdayCell.swift
//  Threads
//
//  Created by Igor Cova on 08/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class BirthdayCell: UITableViewCell {

    @IBOutlet weak var dpBirthday: UIDatePicker!
    var member: Member?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func datePickerValue(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        self.member?.birthdayDateStr = dateFormatter.stringFromDate(dpBirthday.date)
    }
    
    func setCell(mem: Member) {
        self.member = mem
        if let dt = self.member?.birthdayDate {
            dpBirthday.date = dt
        } else {
            let adulthood = NSCalendar.currentCalendar().dateByAddingUnit(
                .Year,
                value: -18,
                toDate: NSDate(),
                options: NSCalendarOptions(rawValue: 0))
            
            dpBirthday.date = adulthood!
            
        }
        
    }

}
