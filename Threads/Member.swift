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
    var surname : String
    var userName : String
    var about : String
    var phone : String
    var isMale: Bool
    
    var linkToLogo : String {
        return "\(MemberLogo)/\(id).png"
    }
    
    var fullName : String {
        return "\(name) \(surname)"
    }
    
    
    init (id: Int, name : String, surname : String, userName : String, about : String, phone : String, isMale: Bool) {
        self.id = id
        self.name = name
        self.surname = surname
        self.userName = userName
        self.about = about
        self.phone = phone
        self.isMale = isMale
    }
}

class MemberEntryFields {
    var id : Int
    var sessionId: String
    
    init (id: Int, sessionId: String) {
        self.id = id
        self.sessionId = sessionId
    }
}