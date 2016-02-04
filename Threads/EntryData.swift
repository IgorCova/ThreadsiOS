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
                         id:            comm["Entry_ID"].int!
                        ,communityId:   comm["Community_ID"].int!
                        ,communityName: comm["Community_Name"].string!
                        ,columnId:      comm["ColumnCommunity_ID"].int!
                        ,columnName:    comm["ColumnCommunity_Name"].string!
                        ,date:          comm["Entry_CreateDateEst"].string!
                        ,text:          comm["Entry_Text"].string!)
                    entries.append(ent)
                }
                completion(entries: entries, successful: true)
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError!) in
                print("Error: " + error.localizedDescription)
                completion(entries: [], successful: false)
        })
    }
    
    func wsEntrySave(wsEntry: NewEntry, completion : (id :Int, successful: Bool) -> Void) {
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        
        let communityId = wsEntry.communityId
        let columnId = wsEntry.columnId
        let entrytext = wsEntry.text
        manager.POST("\(Threads)/Entry_Save"
            ,parameters: ["Session": "1234567890", "DID": "CovaPhone", "Params": ["CommunityID": communityId, "ColumnID": columnId, "CreatorID": MyMemberID, "EntryText": entrytext]]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                //print("JSON: " + responseObject.description)
                let entryData = JSON(responseObject)["Data"].dictionaryValue
                
                if let entryID = entryData["ID"]?.int {
                   completion(id: entryID, successful: true)
                } else {
                    completion(id: 1, successful: true)
                }
                
                
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError!) in
                print("Error: " + error.localizedDescription)
                completion(id: 0, successful: false)
        })
    }


}