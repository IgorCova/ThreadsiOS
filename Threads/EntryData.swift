//
//  EntryData.swift
//  Threads
//
//  Created by Igor Cova on 17/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import Foundation
import Alamofire

class EntryData {
    
    private var entries = [Entry]()
    
    func wsGetEntryReadByCommunityID(id: Int, completion : (entries:[Entry], successful: Bool) -> Void) {
        let prms = ["Session": "1234567890", "DID": "CovaPhone", "Params": ["CommunityID": id]]
        Alamofire.request(.POST, "\(Threads)/Entry_ReadByCommunityID", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    
                    for comm in json {
                        let ent = Entry(
                             id:            comm["Entry_ID"].int!
                            ,communityId:   comm["Community_ID"].int!
                            ,communityName: comm["Community_Name"].string!
                            ,columnId:      comm["ColumnCommunity_ID"].int!
                            ,columnName:    comm["ColumnCommunity_Name"].string!
                            ,date:          comm["Entry_CreateDateEst"].string!
                            ,text:          comm["Entry_Text"].string!)
                        self.entries.append(ent)
                    }
                    completion(entries: self.entries, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(entries: self.entries, successful: false)
                }
        }
    }
    
    func wsEntrySave(wsEntry w: NewEntry, completion : (id :Int, successful: Bool) -> Void) {
        let prms = ["Session": "1234567890", "DID": "CovaPhone", "Params": ["CommunityID": w.communityId, "ColumnID": w.columnId, "CreatorID": MyMemberID, "EntryText": w.text]]
        Alamofire.request(.POST, "\(Threads)/Entry_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionaryValue
                    
                    if let entryID = json["ID"]?.int {
                        completion(id: entryID, successful: true)
                    } else {
                        completion(id: 0, successful: true)
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(id: 0, successful: false)
                }
        }
    }
}