//
//  MenuView.swift
//  Threads
//
//  Created by Admin on 28.11.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class MenuView: UIViewController {

    @IBOutlet weak var lblPersonName: UILabel!
    @IBOutlet weak var imgPerson: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgPerson.image = UIImage(named: "ComLogos/CovaImg.png")
        self.imgPerson.layer.cornerRadius = self.imgPerson.frame.size.height/2
        self.imgPerson.layer.masksToBounds = true
        self.imgPerson.layer.borderWidth = 0.1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showCommunities() {
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
