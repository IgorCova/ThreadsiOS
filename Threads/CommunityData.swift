//
//  CommunityData.swift
//  Threads
//
//  Created by Igor Cova on 17/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import Foundation
import Alamofire

class CommunityData {
    var dataj: NSData?
    private var communities = [Community]()
    
    func wsGetCommunityDict(memberID : Int, completion : (comms:[Community], successful: Bool) -> Void) {
        let prms = ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["MemberID": memberID]]
        Alamofire.request(.POST, "\(Threads)/Community_ReadDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    
                    for comm in json {
                        let id = comm["ID"].int!
                        let cm = Community(id: id, name: comm["Name"].string!, isMember: comm["IsMember"].bool!, countMembers: comm["CountMembers"].string!, defaultColumnId : comm["DefaultColumnID"].int!)
                        self.communities.append(cm)
                    }
                    completion(comms: self.communities, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(comms: self.communities, successful: false)
                }
        }
    }
    
    func wsGetCommunityMyDict(memberID : Int, completion : (comms:[Community], successful: Bool) -> Void) {
        let prms = ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["MemberID": memberID]]
        Alamofire.request(.POST, "\(Threads)/Community_ReadMyDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    
                    for comm in json {
                        let id = comm["ID"].int!
                        let cm = Community(id: id, name: comm["Name"].string!, isMember: comm["IsMember"].bool!, countMembers: comm["CountMembers"].string!, defaultColumnId : comm["DefaultColumnID"].int!)
                        self.communities.append(cm)
                    }
                    completion(comms: self.communities, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(comms: self.communities, successful: false)
                }
        }
    }
    
    func wsGetCommunitySuggestDict(memberID : Int, completion : (comms:[Community], successful: Bool) -> Void) {
        let prms = ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["MemberID": memberID]]
        Alamofire.request(.POST, "\(Threads)/Community_ReadSuggestDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    
                    for comm in json {
                        let id = comm["ID"].int!
                        let cm = Community(id: id, name: comm["Name"].string!, isMember: comm["IsMember"].bool!, countMembers: comm["CountMembers"].string!, defaultColumnId : comm["DefaultColumnID"].int!)
                        self.communities.append(cm)
                    }
                    completion(comms: self.communities, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(comms: self.communities, successful: false)
                }
        }
    }
}