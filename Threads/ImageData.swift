//
//  ImageData.swift
//  Threads
//
//  Created by Igor Cova on 27/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation
import Alamofire

class ImageData {
    func wsLogoSave(logo: UIImage, completion : (isOk: Bool, successful: Bool) -> Void) {
        let imageData : NSData = UIImagePNGRepresentation(imageWithSize(logo, size: CGSizeMake(75, 75)))!
        let base64String : NSString = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["isMember": true, "id": MyMemberID, "logoData": base64String]]
        //print (logo.size)
        Alamofire.request(.POST, "\(Threads)/LogoSave", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionary
                    let isOk = json!["isOk"]?.bool
    
                    completion(isOk: isOk!, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(isOk: false, successful: false)
                }
        }
    }
    
    func imageWithSize(image: UIImage,size: CGSize) -> UIImage {
        if UIScreen.mainScreen().respondsToSelector("scale") {
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        }
        else {
            UIGraphicsBeginImageContext(size)
        }
        
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func resizeImageWithAspect(image: UIImage,scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat) -> UIImage {
        //let scaleFactor =  width / height;
        let newSize = CGSizeMake(width, height);
        return imageWithSize(image, size: newSize);
    }
}