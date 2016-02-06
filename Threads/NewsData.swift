//
//  NewsData.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation
import Alamofire

class NewsData {
    private var arNews = [Entry]()
    
    func wsGetNewsReadByMemberID(id: Int, completion : (arNews:[Entry], successful: Bool) -> Void) {
        
        let prms = ["Session": "1234567890", "DID": "CovaPhone", "Params": ["MemberID": id]]
        Alamofire.request(.POST, "\(Threads)/News_ReadByMemberID", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    var entries = [Entry]()
                    for post in json {
                        let ent = Entry(
                            id:             post["Entry_ID"].int!
                            ,communityId:   post["Community_ID"].int!
                            ,communityName: post["Community_Name"].string!
                            ,columnId:      post["ColumnCommunity_ID"].int!
                            ,columnName:    post["ColumnCommunity_Name"].string!
                            ,date:          post["Entry_CreateDateEst"].string!
                            ,text:          post["Entry_Text"].string!)
                        entries.append(ent)
                    }
                    completion(arNews: entries, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(arNews: [], successful: false)
                }
        }
    }
    
}
