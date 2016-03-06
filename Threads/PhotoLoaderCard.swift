//
//  PhotoLoaderCard.swift
//  Threads
//
//  Created by Igor Cova on 28/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import UIKit

class PhotoLoaderCard: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, RSKImageCropViewControllerDelegate  {
    
    @IBOutlet weak var imgPhoto: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgPhoto.imageFromUrl(memberLogoUrl(MyMemberID))
        self.btmSetPhoto_Click(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btmSetPhoto_Click(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
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
        saveImageToData(croppedImage)
        self.imgPhoto.image = croppedImage
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func imageCropViewController(controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        saveImageToData(croppedImage)
        self.imgPhoto.image = croppedImage
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func saveImageToData(image: UIImage)  {
        ImageData().wsLogoSave(image) { (isOk, successful) -> Void in
            if isOk == true {
                print("Good")
            } else {
                print("Bad")
                self.imgPhoto.image = nil
                let pnlLab = UIView(frame: CGRect(x: 0, y: -60, width: 320, height: 60))
                pnlLab.backgroundColor = CommColor.colorWithAlphaComponent(0.75)
                
                let labelInfo = UILabel(frame: CGRect(x: 0, y: 20, width: 320, height: 20))
                labelInfo.text = "Image isn't black and white"
                labelInfo.font = SFUIDisplayReg
                labelInfo.textColor = .whiteColor()
                labelInfo.textAlignment = .Center
                
                pnlLab.addSubview(labelInfo)
                self.view.addSubview(pnlLab)
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                    pnlLab.center.y = 30
                    
                    }, completion: nil)
                
                UIView.animateWithDuration(0.2, delay: 3, options: .CurveLinear, animations: {
                    pnlLab.center.y = -30
                    
                    }, completion: {(value Bool) in
                        pnlLab.hidden = true
                })
            }
        }
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
