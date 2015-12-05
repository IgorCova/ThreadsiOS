//
//  MenuView.swift
//  Threads
//
//  Created by Admin on 28.11.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit
import CoreData

class MenuView: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet weak var btnAllCom: UIButton!
    @IBOutlet weak var lblPersonName: UILabel!
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var btnMyCom: UIButton!
    @IBOutlet weak var btnSuggested: UIButton!
    @IBOutlet weak var btnPopular: UIButton!
    @IBOutlet weak var btnControl: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var btnNews: UIButton!
    @IBOutlet weak var btnBookmarks: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgPerson.image = UIImage(named: "ComLogos/CovaImg.png")
        self.imgPerson.layer.cornerRadius = self.imgPerson.frame.size.height/2
        self.imgPerson.layer.masksToBounds = true
        self.imgPerson.layer.borderWidth = 0.1
        
        self.lblPersonName.text = "Cova Igor"
        
        self.btnNews.setImage(UIImage(named: "ComLogos/News.png"), forState: .Normal)
        self.btnAllCom.setImage(UIImage(named: "ComLogos/AllCommunities.png"), forState: .Normal)
        self.btnMyCom.setImage(UIImage(named: "ComLogos/MyCommunities.png"), forState: .Normal)
        self.btnSuggested.setImage(UIImage(named: "ComLogos/Suggested.png"), forState: .Normal)
        self.btnPopular.setImage(UIImage(named: "ComLogos/Popular.png"), forState: .Normal)
        self.btnControl.setImage(UIImage(named: "ComLogos/Control.png"), forState: .Normal)
        self.btnSettings.setImage(UIImage(named: "ComLogos/Settings.png"), forState: .Normal)
        self.btnBookmarks.setImage(UIImage(named: "ComLogos/Bookmarks.png"), forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in })
        self.imgPerson.image = image
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let newImage = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context)
        newImage.setValue(image.description, forKey: "photo")
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = segue.destinationViewController as! UINavigationController
        let comm = navController.viewControllers[0] as! CommunityDir
        
        if (segue.identifier == "ShowMyComm") {
            comm.isOnlyMyCommunities = true
        } else if (segue.identifier == "ShowAllComm") {
            comm.isOnlyMyCommunities = false
        } 
    }
    

}
