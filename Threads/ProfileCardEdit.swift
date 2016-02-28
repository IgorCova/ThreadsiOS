//
//  ProfileCardEdit.swift
//  Threads
//
//  Created by Igor Cova on 11/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit
import Alamofire

class ProfileCardEdit: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, RSKImageCropViewControllerDelegate {

    @IBOutlet weak var txflUsername: UITextField!
    @IBOutlet weak var txflSurname: UITextField!
    @IBOutlet weak var txflName: UITextField!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var txtAbout: UITextView!
    
    var member: Member?
  
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.title = " "
       
        self.txflName.text = self.member!.name
        self.txflSurname.text = self.member!.surname
        self.txflUsername.text = self.member!.userName
        self.txtAbout.text = self.member!.about
        
        imgPhoto.imageFromUrl("\(MemberLogo)/\(MyMemberID).png")
        self.imgPhoto.layer.cornerRadius = self.imgPhoto.frame.size.height/2
        self.imgPhoto.layer.masksToBounds = true
        self.imgPhoto.layer.borderWidth = 0.1
        
        self.txflName.delegate = self
        self.txflName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setPhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            
        }
    }

    @IBAction func doneEdit(sender: AnyObject) {
        self.member?.name = txflName.text!
        self.member?.surname = txflSurname.text!
        self.member?.userName = txflUsername.text!
        self.member?.about = txtAbout.text

        MemberData().wsMemberSave(member!) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                let Core = self.storyboard!.instantiateViewControllerWithIdentifier("Core") as! SWRevealViewController
                self.presentViewController(Core, animated:true, completion:nil)
            }
        }
    }

    @IBAction func saveMember(sender: AnyObject) {
        self.member?.name = txflName.text!
        self.member?.surname = txflSurname.text!
        self.member?.userName = txflUsername.text!
        self.member?.about = txtAbout.text

        MemberData().wsMemberSave(member!) {memberInstance, successful in
            if successful {
                self.member = memberInstance
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(false, completion: { () -> Void in
            var imageCropVC : RSKImageCropViewController!
            imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.Circle)
            imageCropVC.rotationEnabled = true
            imageCropVC.delegate = self
            
            self.navigationController?.pushViewController(imageCropVC, animated: true)
        })
    }
    
    func imageCropViewController(controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        // saveImageToData(croppedImage)
        self.imgPhoto.image = croppedImage
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func imageCropViewController(controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        //saveImageToData(croppedImage)
        self.imgPhoto.image = croppedImage
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func imageCropViewControllerDidCancelCrop(controller: RSKImageCropViewController) {
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func imageWithSize(image: UIImage,size: CGSize)->UIImage{
        if UIScreen.mainScreen().respondsToSelector("scale") {
            UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.mainScreen().scale);
        }
        else {
            UIGraphicsBeginImageContext(size);
        }
        
        image.drawInRect(CGRectMake(0, 0, size.width, size.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    func resizeImageWithAspect(image: UIImage,scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat)->UIImage {
        //let scaleFactor =  width / height;
        let newSize = CGSizeMake(width, height);
        return imageWithSize(image, size: newSize);
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
