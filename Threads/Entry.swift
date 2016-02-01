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
    init (   id: Int
            ,communityId : Int
            ,communityName: String
            ,columnId : Int
            ,columnName : String
            ,date : String
            ,text : String
        ) {
        self.id = id
        self.communityId = communityId
        self.communityName = communityName
        self.columnId = columnId
        self.columnName = columnName
        self.date = date
        self.text = text
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

