//
//  ViewController.swift
//  Threads
//
//  Created by Jin-Mac on 04.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class CommunityDirs: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tvCommunity: UITableView!
    
    var dir : [Community] = [Community]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCommunityDir()
        self.tvCommunity.delegate = self
        self.tvCommunity.dataSource = self
        self.tvCommunity.separatorStyle = UITableViewCellSeparatorStyle.None        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setCommunityDir() {
        let c1 = Community(name: "UbuntuUbuntuUbuntuUbuntuUbuntuUbuntuUbuntuUbuntu", typeID: 1, categoryID: 1, linkToImage: "ComLogos/UbuntuCircuitrySilver.png")
        let c2 = Community(name: "Major Mafia", typeID: 1, categoryID: 2, linkToImage: "ComLogos/mfK.png")
        let c3 = Community(name: "mr Freeman", typeID: 1, categoryID: 1, linkToImage: "ComLogos/mfO.png")
        let c4 = Community(name: "AppStore", typeID: 1, categoryID: 1, linkToImage: "ComLogos/app_store.png")
        let c5 = Community(name: "Health", typeID: 1, categoryID: 1, linkToImage: "ComLogos/heart.png")
        let c6 = Community(name: "Freedom", typeID: 1, categoryID: 1, linkToImage: "ComLogos/MFG.png")
        let c7 = Community(name: "SpitFire", typeID: 1, categoryID: 1, linkToImage: "ComLogos/mfS.png")
        let c8 = Community(name: "Show", typeID: 1, categoryID: 1, linkToImage: "ComLogos/mF.png")
        let c9 = Community(name: "Associated", typeID: 1, categoryID: 1, linkToImage: "ComLogos/mfas.png")
        let c0 = Community(name: "Your flag", typeID: 1, categoryID: 1, linkToImage: "ComLogos/mer.png")
        
        dir.append(c1)
        dir.append(c2)
        dir.append(c3)
        dir.append(c4)
        dir.append(c5)
        dir.append(c6)
        dir.append(c7)
        dir.append(c8)
        dir.append(c9)
        dir.append(c0)
    }
    
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dir.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CommunityCell = (tableView.dequeueReusableCellWithIdentifier("CommunityCell") as? CommunityCell)!
        cell.setCell(dir[indexPath.row])
        
        return cell
    }
    
   
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1.0)
        
        let lbl = UILabel()
        lbl.text = "-----Suggest community-----"
        lbl.font.fontWithSize(10.0)
        lbl.sizeToFit()
        lbl.textColor = UIColor.whiteColor()
        lbl.center = CGPointMake(tvCommunity.frame.size.width/2, 12.5)
        
        view.addSubview(lbl)
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row % 2 == 0 {        
            return 110.0 }
        else {
            return 150.0
        }
        
        
    }
    
}

