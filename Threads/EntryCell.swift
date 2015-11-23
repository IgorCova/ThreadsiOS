//
//  EntryCell.swift
//  Threads
//
//  Created by Jin-Mac on 18.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
    
    @IBOutlet weak var lblCommunityName: UILabel!
    @IBOutlet weak var imgCommunity: UIImageView!
    @IBOutlet weak var lblColumnName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var plView: UIView!
    @IBOutlet weak var txTitle: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.imgCommunity.layer.cornerRadius = self.imgCommunity.frame.size.height/2
        self.imgCommunity.layer.masksToBounds = true
        self.imgCommunity.layer.borderWidth = 0.1
        let fixedWidth = self.txTitle.frame.size.width
        self.txTitle.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = self.txTitle.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = self.txTitle.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        self.txTitle.frame = newFrame
        
        //При добавлениии теней начинает все тормозить нужно будет потом что-то придумать
        self.plView.layer.masksToBounds = false
        self.plView.layer.shadowOffset = CGSizeMake(-2, 2)
        self.plView.layer.shadowRadius = 3
        self.plView.layer.shadowOpacity = 0.2
    }
    
    func setCell(entry: Entry) {
        self.lblCommunityName.text = entry.communityName
        self.lblDate.text = entry.date
        self.lblColumnName.text = entry.columnName
        self.txTitle.text = entry.title
        self.imgCommunity.image = UIImage(named: entry.communityImg)
    }

}
