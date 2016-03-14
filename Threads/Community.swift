//
//  Community.swift
//  Threads
//
//  Created by Jin-Mac on 04.10.15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import Foundation

class Community {
    var id : Int
    var name : String
    var description : String?
    var tagline: String?
    var link: String?
    var linkToImage : String {
        return "\(CommLogo)/\(id).png"
    }
    var isMember : Bool
    var countMembers : String
    var defaultColumnId : Int
    
    init (id: Int, name : String, description : String?, tagline: String?, link: String?, isMember : Bool, countMembers : String, defaultColumnId: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.tagline = tagline
        self.link = link
        self.isMember = isMember
        self.countMembers = countMembers
        self.defaultColumnId = defaultColumnId
    }
}