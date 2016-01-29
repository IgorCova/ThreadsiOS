//
//  NewsData.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation

class NewsData {
    private var arNews = [Entry]()
    
    func wsGetNewsReadByPersonID(id: Int, completion : (arNews:[Entry], successful: Bool) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST("\(Threads)/News_ReadByPersonID"
            ,parameters: ["Session": "1234567890", "DID": "CovaPhone", "Params": ["PersonID": id]]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                //print("JSON: " + responseObject.description)
                let newsData = JSON(responseObject)["Data"].arrayValue
                var entries = [Entry]()
                for post in newsData {
                    let ent = Entry(
                        id: post["EntryID"].int!
                        ,communityId: post["CommunityID"].int!
                        ,communityName: post["CommunityID_Name"].string!
                        ,columnName: post["ColumnCommunityID_Name"].string!
                        ,date: "18.10.15 20:20"
                        ,text: post["EntryID_EntryText"].string!)
                    entries.append(ent)
                }
                completion(arNews: entries, successful: true)
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError!) in
                print("Error: " + error.localizedDescription)
                completion(arNews: [], successful: false)
        })
    }
    
}
