//
//  MemberEntry.swift
//  Threads
//
//  Created by Igor Cova on 15/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation
import CoreData

class MemberEntry: NSManagedObject {
    
}

extension MemberEntry {
    @NSManaged var memberid: NSData?
    @NSManaged var sessionid: NSData?
}

