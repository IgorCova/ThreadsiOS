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
    /*var typeID : Int8
    var typeName : String {
        return getCommunityTypeNameByID(typeID)
    }
    var categoryID : Int8
    var categoryName : String {
        return getCommunityCategoryNameByID(categoryID)
    }*/
    var linkToImage : String
    var inMyList : Bool
    var countMembers : String
    
    init (id: Int, name : String, linkToImage : String, inMyList : Bool, countMembers : String) {
        self.id = id
        self.name = name
       /* self.typeID = typeID
        self.categoryID = categoryID*/
        self.linkToImage = linkToImage
        self.inMyList = inMyList
        self.countMembers = countMembers
    }
}

/*class CommunityType {
    var name : String
    var id: Int8
    
    init (name : String, id: Int8) {
        self.name = name
        self.id = id
    }
}

var dirCommunityType = [CommunityType]()

func getCommunityTypeNameByID(id: Int8) -> String {
    if dirCommunityType.count == 0 {
        let ct1 = CommunityType(name: "Public", id: 1)
        let ct2 = CommunityType(name: "Private", id: 2)
        dirCommunityType.append(ct1)
        dirCommunityType.append(ct2)
    }
    
    for val in dirCommunityType {
        if val.id == id {
            return val.name
        }
    }
    return "Non"
}

class CommunityCategory {
    var name : String
    var id: Int8
    
    init (name : String, id: Int8) {
        self.name = name
        self.id = id
    }
}

var dirCommunityCategory = [CommunityCategory]()

func setCommunityCategory() {
    let cc1 = CommunityCategory(name: "Social Networking", id: 1)
    let cc2 = CommunityCategory(name: "Sport", id: 2)
    let cc3 = CommunityCategory(name: "Entertainment", id: 3)
    dirCommunityCategory.append(cc1)
    dirCommunityCategory.append(cc2)
    dirCommunityCategory.append(cc3)
}

func getCommunityCategoryNameByID(id: Int8) -> String {
    if dirCommunityCategory.count == 0 {
        setCommunityCategory()
    }
    
    for val in dirCommunityCategory {
        if val.id == id {
            return val.name
        }
    }
    
    return "Non"
}*/