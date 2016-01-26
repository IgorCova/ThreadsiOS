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
                print("JSON: " + responseObject.description)
                let communityDict = JSON(responseObject)["Community_ReadDictResult"]["Data"].arrayValue
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
    
    func loadDefData() {
        let c1 = Community(id: 1, name: "Threads", inMyList: true, countMembers: "1145")
        let c2 = Community(id: 2, name: "Threads Design", inMyList: true, countMembers: "214")
        let c3 = Community(id: 3, name: "Run Foundation", inMyList: true, countMembers: "1098")
        let c4 = Community(id: 4, name: "Cross Join", inMyList: false, countMembers: "310")
        let c5 = Community(id: 5, name: "Major Mafia", inMyList: false, countMembers: "18017")
        let c6 = Community(id: 6, name: "Digital Tectonics", inMyList: true, countMembers: "1145")
        let c7 = Community(id: 7, name: "Eat Sleep JDM", inMyList: true, countMembers: "214")
        
        self.communities.append(c1)
        self.communities.append(c2)
        self.communities.append(c3)
        self.communities.append(c4)
        self.communities.append(c5)
        self.communities.append(c6)
        self.communities.append(c7)
    }
    
}