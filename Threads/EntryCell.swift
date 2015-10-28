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
    @IBOutlet weak var imgRedactor: UIImageView!
    @IBOutlet weak var lblRedactorName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txTitle: UITextView!
    @IBOutlet weak var lblLikeText: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.imgRedactor.layer.cornerRadius = self.imgRedactor.frame.size.height/2
        self.imgRedactor.layer.masksToBounds = true
        self.imgRedactor.layer.borderWidth = 0.1
        
        let fixedWidth = self.txTitle.frame.size.width
        self.txTitle.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = self.txTitle.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = self.txTitle.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        self.txTitle.frame = newFrame
    }
    
    func setCell(entry: Entry) {
        self.lblCommunityName.text = entry.communityName + " (" + entry.columnName + ")"
        self.lblDate.text = entry.date
        self.lblRedactorName.text = entry.redactorName
        self.txTitle.text = entry.title
        self.imgRedactor.image = UIImage(named: "ComLogos/UbuntuCircuitrySilver.png")
        self.lblLikeText.text = "\(entry.likeText)"
        self.lblLikes.text = " \(entry.likes)"
        
        if (entry.likes / 10) < 1 {
            self.lblLikes.frame.size.width = CGFloat(NSInteger(15))
        } else if (entry.likes / 10) < 10 {
            self.lblLikes.frame.size.width = CGFloat(NSInteger(25))
        } else if (entry.likes / 10) < 100 {
            self.lblLikes.frame.size.width = CGFloat(NSInteger(35))
        } else {
            self.lblLikes.frame.size.width = CGFloat(NSInteger(45))
        }        
        
    }

}
