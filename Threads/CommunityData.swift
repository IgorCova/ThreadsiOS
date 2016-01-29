//
//  CommunityData.swift
//  Threads
//
//  Created by Igor Cova on 17/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import Foundation
import SwiftyJSON

class CommunityData {
    var dataj: NSData?
    private var communities = [Community]()
    
    func wsGetCommunityDict(completion : (comms:[Community], successful: Bool) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST("\(Threads)/Community_ReadDict",
             parameters: ["Session": "1234567890", "DID" : "CovaPhone", "Params": []]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                //print("JSON: " + responseObject.description)
                let communityDict = JSON(responseObject)["Data"].arrayValue
                var communities = [Community]()
                
                for comm in communityDict {
                    let id = comm["ID"].int!
                    let cm = Community(id: id, name: comm["Name"].string!, inMyList: true, countMembers: "100")
                    communities.append(cm)
                }
                completion(comms: communities, successful: true)
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError!) in
                print("Error: " + error.localizedDescription)
                completion(comms: [], successful: false)
        })
    }
    
}