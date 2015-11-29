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

    @IBOutlet weak var lblPersonName: UILabel!
    @IBOutlet weak var imgPerson: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgPerson.image = UIImage(named: "ComLogos/CovaImg.png")
        self.imgPerson.layer.cornerRadius = self.imgPerson.frame.size.height/2
        self.imgPerson.layer.masksToBounds = true
        self.imgPerson.layer.borderWidth = 0.1
        
        //self.imgPerson.image = 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showCommunities() {
    }

    @IBAction func setPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("\nButton capture")
            
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            self.imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in })
        self.imgPerson.image = image
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let newImage = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context)
        newImage.setValue(image.description, forKey: "photo")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
