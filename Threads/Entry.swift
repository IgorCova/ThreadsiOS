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
  //var communityID : Int
    var communityName : String
    var communityImg : String
    
  //var columnID : Int
    var columnName : String
    
  //var redactorID : Int
    var date : String
    var title : String
    init (   id: Int
          //,communityID : Int
            ,communityName : String
            ,communityImg : String
        
          //,columnID : Int
            ,columnName : String
        
          //,redactorID : Int
            ,date : String
            ,title : String
        ) {
        self.id = id
        self.communityName = communityName
        self.columnName = columnName
        self.communityImg = communityImg
        self.date = date
        self.title = title
    }
}
