//
//  MemberData.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//
import Foundation
import Alamofire

class MemberData {
    func wsGetMemberInstance(id: Int, completion : (memberInstance: Member?, successful: Bool) -> Void) {
        let prms = ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["MemberID": id]]
        Alamofire.request(.POST, "\(Threads)/Member_ReadInstance", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionaryValue
                    let mem = Member (
                         id: json["ID"]!.int!
                        ,name: json["Name"]!.string!
                        ,surname: json["Surname"]!.string!
                        ,userName: json["UserName"]!.string!
                        ,about: json["About"]!.string!
                        ,phone: json["Phone"]!.string!)
                    
                    completion(memberInstance: mem, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(memberInstance: nil, successful: false)
                }
        }
    }
    
    func wsMemberSave(member: Member, completion : ( memberInstance: Member?, successful: Bool) -> Void) {
        let jcmem = ["ID": member.id, "Name": member.name, "Surname": member.surname, "UserName":member.userName, "About":member.about, "Phone": member.phone]
        let prms = ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["Member": jcmem]]
        Alamofire.request(.POST, "\(Threads)/Member_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionaryValue
                    let mem = Member (
                         id: json["ID"]!.int!
                        ,name: json["Name"]!.string!
                        ,surname: json["Surname"]!.string!
                        ,userName: json["UserName"]!.string!
                        ,about: json["About"]!.string!
                        ,phone: json["Phone"]!.string!)
                    
                    completion(memberInstance: mem, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(memberInstance: nil, successful: false)
                }
        }
    }
}