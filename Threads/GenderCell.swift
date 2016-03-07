//
//  GenderCell.swift
//  Threads
//
//  Created by Igor Cova on 07/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

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