//
//  ColumnsCell.swift
//  Threads
//
//  Created by Igor Cova on 17/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class ColumnsCell: UITableViewCell, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var community: Community?
    var columns = [ColumnCommunity]()// = [("All posts", 1), ("Radio", 3), ("Funny pictures", 3), ("Classical music", 4), ("Hot line", 5)]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func refresh() {
        CommunityData().wsGetColumnCommunity(community!.id) { (columns, successful) -> Void in
            if successful {
                self.columns = columns
                self.showColumns()
            }
        }
    }
    
    func showColumns() {
        self.scrollView.delegate = self
        var columnX: CGFloat = 15.0
        for clmn in self.columns {
            let button = UIButton(type: .System) as UIButton
            button.setTitleColor(CommColor, forState: .Normal)
            button.backgroundColor = .whiteColor()
            button.frame = CGRectMake(columnX , 4, 50, 30)
            button.titleLabel?.font = UIFont(name: ".SFUIText-Regular", size: 14)
            button.setTitle(clmn.name, forState: .Normal)
            button.sizeToFit()
            button.titleLabel?.textAlignment = .Center
            button.tag = clmn.id
            columnX = columnX + button.frame.width + 15
            
            if clmn.id != self.community?.defaultColumnId {
                button.setTitleColor(UIColor.blackColor().colorWithAlphaComponent(0.7), forState: .Normal)
            }
            
            button.addTarget(self, action: #selector(ColumnsCell.buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollView.addSubview(button)
        }
        
        self.scrollView.contentSize.width = columnX
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func buttonAction(sender: UIButton) {
        for view in self.scrollView.subviews {
            if view.isKindOfClass(UIButton) == true {
                (view as! UIButton).setTitleColor(UIColor.blackColor().colorWithAlphaComponent(0.7), forState: .Normal)
            }
        }
        sender.setTitleColor(CommColor, forState: .Normal)
        
        self.community?.defaultColumnId = sender.tag
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
    }
    
    func setCell(comm: Community) {
        self.community = comm
        self.refresh() 
    }

}
