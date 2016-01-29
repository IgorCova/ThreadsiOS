//
//  EntryData.swift
//  Threads
//
//  Created by Igor Cova on 17/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import Foundation

class EntryData {
    
    private var entries = [Entry]()
    
    func wsGetEntryReadByCommunityID(id: Int, completion : (entries:[Entry], successful: Bool) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST("\(Threads)/Entry_ReadByCommunityID"
            ,parameters: ["Session": "1234567890", "DID": "CovaPhone", "Params": ["CommunityID": id]]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                //print("JSON: " + responseObject.description)
                let communityDict = JSON(responseObject)["Data"].arrayValue
                var entries = [Entry]()
                for comm in communityDict {
                    let ent = Entry(
                         id: comm["ID"].int!
                        ,communityId: comm["CommunityID"].int!
                        ,communityName: comm["CommunityID_Name"].string!
                        ,columnName: comm["ColumnID_Name"].string!
                        ,date: "18.10.15 20:20"
                        ,text: comm["EntryText"].string!)
                    entries.append(ent)
                }
                completion(entries: entries, successful: true)
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError!) in
                print("Error: " + error.localizedDescription)
                completion(entries: [], successful: false)
        })
    }

}