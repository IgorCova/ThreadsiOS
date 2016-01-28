//
//  News.swift
//  Threads
//
//  Created by Igor Cova on 27/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation

class News {
    var communityId : Int
    var communityId_Name : String
    var communityId_linkToLogo : String {
        return "\(CommLogo)/\(communityId).png"
    }
    var entryId : Int
    var entryId_EntryText : String
    var entryId_CreateDate : String
    var columnCommunityId_Name : String
    
    init (communityId: Int, communityId_Name : String, entryId : Int, entryId_EntryText: String, entryId_CreateDate : String, columnCommunityId_Name : String) {
        self.communityId = communityId
        self.communityId_Name = communityId_Name
        self.entryId = entryId
        self.entryId_EntryText = entryId_EntryText
        self.entryId_CreateDate = entryId_CreateDate
        self.columnCommunityId_Name = columnCommunityId_Name
    }
}
