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
    var linkToImage : String {
        return "\(CommLogo)/\(id).png"
    }
    var isMember : Bool
    var countMembers : String
    
    init (id: Int, name : String, isMember : Bool, countMembers : String) {
        self.id = id
        self.name = name
        self.isMember = isMember
        self.countMembers = countMembers
    }
}