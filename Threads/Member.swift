//
//  Member.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation

class Member {
    var id : Int
    var name : String
    var userName : String
    var fullName : String
    var linkToLogo : String {
        return "\(MemberLogo)/\(id).png"
    }
    var about : String
    
    init (id: Int, name : String, userName : String, fullName : String, about : String) {
        self.id = id
        self.name = name
        self.userName = userName
        self.fullName = fullName
        self.about = about
    }
}