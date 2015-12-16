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
    
    var communityName: String {
        return CommunityData().getNameById(communityId)
    }
    
    var communityImg : String {
        return CommunityData().getLogoById(communityId)
    }

    var columnName : String
    var date : String
    var title : String
    init (   id: Int
            ,communityId : Int
            ,columnName : String
            ,date : String
            ,title : String
        ) {
        self.id = id
        self.communityId = communityId
        self.columnName = columnName
        self.date = date
        self.title = title
    }
}
