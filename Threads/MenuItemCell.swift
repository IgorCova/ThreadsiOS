//
//  MenuItemCell.swift
//  Threads
//
//  Created by Igor Cova on 09/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        self.imageView!.frame = CGRectMake(10, 10, 23, 23)
        self.imageView!.autoresizingMask = .None
        self.imageView!.autoresizesSubviews = false
        self.imageView!.contentMode = .ScaleAspectFit
        
        self.textLabel?.frame = CGRectMake(50, 10, 290, 23)
        self.textLabel!.textColor = .whiteColor()
        self.textLabel!.font = UIFont(name: "SF UI Display", size: 19)
        self.textLabel?.highlightedTextColor = UIColor(netHex: 0x0D3B5A)
    }
}
