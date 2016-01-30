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
        manager.POST("\(Threads)/News_ReadByMemberID"
            ,parameters: ["Session": "1234567890", "DID": "CovaPhone", "Params": ["MemberID": id]]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                print("JSON: " + responseObject.description)
                
                let newsData = JSON(responseObject)["Data"].arrayValue
                var entries = [Entry]()
                for post in newsData {
                    let ent = Entry(
                        id:             post["Entry_ID"].int!
                        ,communityId:   post["Community_ID"].int!
                        ,communityName: post["Community_Name"].string!
                        ,columnName:    post["ColumnCommunity_Name"].string!
                        ,date:          "18.10.15 20:25"
                        ,text:          post["Entry_Text"].string!)
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
