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
    //var columnID : Int
    var columnName : String
    //var redactorID : Int
    var redactorImg : String
    var redactorName : String
    var date : String
    var title : String
    var likeText : String
    //var likeLogo : String
    var likes : Int
    init (   id: Int
          //,communityID : Int
            ,communityName : String
          //,columnID ://,v
            ,columnName : String
          //,redactorID : Int
            ,redactorName : String
            ,redactorImg : String
            ,date : String
            ,title : String
          //,likeLogo : String
            ,likeText : String
        ,likes : Int) {
        self.id = id
        self.communityName = communityName
        self.columnName = columnName
        self.redactorName = redactorName
        self.redactorImg = redactorImg
        self.date = date
        self.title = title
        self.likeText = likeText
        self.likes = likes
    }
}
