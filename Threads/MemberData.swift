//
//  MemberData.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//
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
                        ,userName: json["UserName"]!.string!
                        ,fullName: json["FullName"]!.string!
                        ,about: json["About"]!.string!)
                    
                    completion(memberInstance: mem, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(memberInstance: nil, successful: false)
                }
        }
    }
}