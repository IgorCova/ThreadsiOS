//
//  Session.swift
//  Threads
//
//  Created by Igor Cova on 13/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation

class SessionReq {
    var dID : String
    var phone : String
    
    init (dID : String, phone : String) {
        self.dID = dID
        self.phone = phone
    }
}

class Session {
    var dID : String
    var phone : String
    
    init (dID : String, phone : String) {
        self.dID = dID
        self.phone = phone
    }
}