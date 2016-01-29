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
    var columnName : String
    var date : String
    var text : String
    init (   id: Int
            ,communityId : Int
            ,communityName: String
            ,columnName : String
            ,date : String
            ,text : String
        ) {
        self.id = id
        self.communityId = communityId
        self.communityName = communityName
        self.columnName = columnName
        self.date = date
        self.text = text
    }
}
