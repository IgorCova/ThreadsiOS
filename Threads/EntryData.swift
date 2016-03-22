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
    
    func wsGetEntryReadByCommunityID(id: Int, columnId: Int, completion : (entries:[Entry], successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["CommunityID": id, "ColumnID": columnId]]
        
        self.entries.append(Entry(id: 0, communityId: id, communityName: "", columnId: columnId, columnName: "", date: "", text: "", creatorId: 0, creatorFullname: "", isPin: false))
        self.entries.append(Entry(id: 0, communityId: id, communityName: "", columnId: columnId, columnName: "", date: "", text: "", creatorId: 0, creatorFullname: "", isPin: false))
        
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
                            ,communityName: comm["Community_Name"].stringValue
                            ,columnId:      comm["ColumnCommunity_ID"].int!
                            ,columnName:    comm["ColumnCommunity_Name"].stringValue
                            ,date:          comm["Entry_CreateDateEst"].stringValue
                            ,text:          comm["Entry_Text"].stringValue
                            ,creatorId:     comm["CreatorID"].int!
                            ,creatorFullname: comm["CreatorID_Fullname"].stringValue
                            ,isPin:         comm["IsPin"].bool!)
                        self.entries.append(ent)
                        //print(comm["Entry_Text"].stringValue)
                    }
                    
                    completion(entries: self.entries, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(entries: self.entries, successful: false)
                }
        }
    }
    
    func wsEntrySave(wsEntry w: NewEntry, completion : (id :Int, successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID,
             "Params": ["CommunityID": w.communityId
                       ,"ColumnID": w.columnId
                       ,"CreatorID": MyMemberID
                       ,"EntryText": w.text]]
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
    
    func wsBookmarkSave(entryId: Int, completion : (isPin: Bool, successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["EntryID": entryId, "MemberID": MyMemberID]]
        Alamofire.request(.POST, "\(Threads)/Bookmark_Save", parameters: prms, encoding: .JSON)
        .responseJSON { response in
            //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionaryValue
                    completion(isPin: json["IsPin"]!.bool ?? false, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(isPin: false, successful: false)
                }
        }
    }
    
    
}