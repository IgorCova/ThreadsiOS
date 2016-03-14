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
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID" : MyDID, "Params": ["MemberID": memberID]]
        Alamofire.request(.POST, "\(Threads)/Community_ReadDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    for comm in json {
                        self.communities.append(self.getComm(comm))
                    }
                    completion(comms: self.communities, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(comms: self.communities, successful: false)
                }
        }
    }
    
    func wsGetCommunityMyDict(memberID : Int, completion : (comms:[Community], successful: Bool) -> Void) {
        let prms : [String : AnyObject]  = ["Session": MySessionID, "DID" : MyDID, "Params": ["MemberID": memberID]]
        Alamofire.request(.POST, "\(Threads)/Community_ReadMyDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    for comm in json {
                        self.communities.append(self.getComm(comm))
                    }
                    completion(comms: self.communities, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(comms: self.communities, successful: false)
                }
        }
    }
    
    func wsGetCommunitySuggestDict(memberID : Int, completion : (comms:[Community], successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID" : MyDID, "Params": ["MemberID": memberID]]
        Alamofire.request(.POST, "\(Threads)/Community_ReadSuggestDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    for comm in json {
                        self.communities.append(self.getComm(comm))
                    }
                    completion(comms: self.communities, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(comms: self.communities, successful: false)
                }
        }
    }
    
    func wsCommunitySave(community: Community, completion : (id: Int, successful: Bool) -> Void) {
        let comm : [String : AnyObject] = ["ID": community.id, "Name": community.name, "Link": community.link ?? "", "Description": community.description ?? "", "Tagline": community.tagline ?? "", "OwnerID": MyMemberID]
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID" : MyDID, "Params": ["Community": comm]]
        Alamofire.request(.POST, "\(Threads)/Community_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionaryValue
                    let id = json["ID"]!.int ?? 0
                    completion(id: id, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(id: 0, successful: false)
                }
        }
    }
    
    private func getComm(comm: JSON) -> Community {
        let comm = Community(
             id: comm["ID"].int!
            ,name: comm["Name"].string!
            ,description: comm["Description"].string
            ,tagline: comm["Tagline"].string
            ,link: comm["Link"].string
            ,isMember: comm["IsMember"].bool!
            ,countMembers: comm["CountMembers"].string!
            ,defaultColumnId : comm["DefaultColumnID"].int!)
        return comm
    }
}