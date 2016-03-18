//
//  EntryCell.swift
//  Threads
//
//  Created by Jin-Mac on 18.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var lblCommunityName: UILabel!
    @IBOutlet weak var imgCommunity: UIImageView!
    @IBOutlet weak var lblColumnName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var plView: UIView!
    @IBOutlet weak var txTitle: UITextView!
    @IBOutlet weak var imgEditor: UIImageView!
    @IBOutlet weak var lblCreatorFullname: UILabel!
    
    var entryInst : Entry?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func btnBookmarkClick() {
        EntryData().wsBookmarkSave(entryInst?.id ?? 0, completion: { (isPin, successful) -> Void in
            if successful {
                self.entryInst!.isPin = isPin
                self.showPins()
             }
        })
    }
    
    func showPins() {
        if entryInst!.isPin == true {
            self.btnBookmark.setImage( UIImage(named: "bookmarkSet"), forState: .Normal)
        } else {
            self.btnBookmark.setImage(UIImage(named: "bookmark"), forState: .Normal)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.imgCommunity.layer.cornerRadius = self.imgCommunity.frame.size.height/2
        self.imgCommunity.layer.masksToBounds = true
        //self.imgCommunity.layer.borderWidth = 0.7
        //self.imgCommunity.layer.borderColor = UIColor.blackColor().CGColor
        
        self.imgEditor.layer.cornerRadius = self.imgEditor.frame.size.height/2
        self.imgEditor.layer.masksToBounds = true
        self.imgEditor.layer.borderWidth = 1.0
        self.imgEditor.layer.borderColor = UIColor.whiteColor().CGColor
        self.txTitle.font = CommFontText
        
        self.lblDate.sizeToFit()
        //self.lblCreatorFullname.sizeToFit()
        
        /*//При добавлениии теней начинает все тормозить нужно будет потом что-то придумать
        self.plView.layer.masksToBounds = false
        self.plView.layer.shadowOffset = CGSizeMake(-2, 2)
        self.plView.layer.shadowRadius = 3
        self.plView.layer.shadowOpacity = 0.2*/
    }
    
    func setCell(entry: Entry) {
        self.entryInst = entry
    
        self.lblCommunityName.text = entry.communityName
        self.lblDate.text = entry.date
        self.lblColumnName.text = entry.columnName
        self.txTitle.text = entry.text
        
        self.imgCommunity.imageFromUrl(entry.communityImg)
        self.imgEditor.imageFromUrl(entry.creatorImg)
        self.lblCreatorFullname.text = ("by \(entry.creatorFullname)")
        
        self.showPins()
        
    }
}
