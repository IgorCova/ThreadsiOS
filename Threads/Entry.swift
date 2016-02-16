//
//  Entry.swift
//  Threads
//
//  Created by Jin-Mac on 18.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import Foundation

class Entry {
    var id : Int
    var communityId : Int
    var communityName: String
    var communityImg : String {
        return "\(CommLogo)/\(communityId).png"
    }
    
    var columnId : Int
    var columnName : String
    var date : String
    var text : String
    
    var creatorId : Int
    var creatorFullname : String
    var creatorImg : String {
        return "\(MemberLogo)/\(creatorId).png"
    }

    
    init (   id: Int
            ,communityId : Int
            ,communityName: String
            ,columnId : Int
            ,columnName : String
            ,date : String
            ,text : String
            ,creatorId : Int
            ,creatorFullname : String
        ) {
        self.id = id
        self.communityId = communityId
        self.communityName = communityName
        self.columnId = columnId
        self.columnName = columnName
        self.date = date
        self.text = text
        self.creatorId = creatorId
        self.creatorFullname = creatorFullname
    }
}

class NewEntry {
    var communityId : Int
    var columnId : Int
    var text : String
    init (
         communityId : Int
        ,columnId : Int
        ,text : String
        ) {
            self.communityId = communityId
            self.columnId = columnId
            self.text = text
    }
}

