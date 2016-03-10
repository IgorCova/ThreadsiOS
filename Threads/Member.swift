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
    var surname : String?
    var userName : String?
    var about : String?
    var phone : String
    var isMale: Bool
    var birthdayDateStr: String?
    var birthdayDate: NSDate? {
        if let dstr = birthdayDateStr {
            return dstr.getDate()
        } else {
            return nil
        }
    }
    
    var linkToLogo : String {
        return "\(MemberLogo)/\(id).png"
    }
    
    var fullName : String {
        return "\(name) \(surname ?? "")"
    }
    
    init (id: Int, name : String, surname : String?, userName : String?, about : String?, phone : String, isMale: Bool, birthdayDateStr: String?) {
        self.id = id
        self.name = name
        self.surname = surname
        self.userName = userName
        self.about = about
        self.phone = phone
        self.isMale = isMale
        self.birthdayDateStr = birthdayDateStr
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