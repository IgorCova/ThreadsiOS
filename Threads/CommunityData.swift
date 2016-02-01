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
    
    func wsGetCommunityDict(memberID : Int, completion : (comms:[Community], successful: Bool) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST("\(Threads)/Community_ReadDict",
             parameters: ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["MemberID": memberID]]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                //print("JSON: " + responseObject.description)
                let communityDict = JSON(responseObject)["Data"].arrayValue
                var communities = [Community]()
                
                for comm in communityDict {
                    let id = comm["ID"].int!
                    let cm = Community(id: id, name: comm["Name"].string!, isMember: comm["IsMember"].bool!, countMembers: "100", defaultColumnId : comm["DefaultColumnID"].int!)
                    communities.append(cm)
                }
                completion(comms: communities, successful: true)
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError!) in
                print("Error: " + error.localizedDescription)
                completion(comms: [], successful: false)
        })
    }
    
    func wsGetCommunityMyDict(memberID : Int, completion : (comms:[Community], successful: Bool) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST("\(Threads)/Community_ReadMyDict",
            parameters: ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["MemberID": memberID]]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                //print("JSON: " + responseObject.description)
                let communityDict = JSON(responseObject)["Data"].arrayValue
                var communities = [Community]()
                
                for comm in communityDict {
                    let id = comm["ID"].int!
                    let cm = Community(id: id, name: comm["Name"].string!, isMember: comm["IsMember"].bool!, countMembers: "150", defaultColumnId : comm["DefaultColumnID"].int!)
                    communities.append(cm)
                }
                completion(comms: communities, successful: true)
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError!) in
                print("Error: " + error.localizedDescription)
                completion(comms: [], successful: false)
        })
    }
    
    func wsGetCommunitySuggestDict(memberID : Int, completion : (comms:[Community], successful: Bool) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST("\(Threads)/Community_ReadSuggestDict",
            parameters: ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["MemberID": memberID]]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                //print("JSON: " + responseObject.description)
                let communityDict = JSON(responseObject)["Data"].arrayValue
                var communities = [Community]()
                
                for comm in communityDict {
                    let id = comm["ID"].int!
                    let cm = Community(id: id, name: comm["Name"].string!, isMember: comm["IsMember"].bool!, countMembers: "200", defaultColumnId : comm["DefaultColumnID"].int!)
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