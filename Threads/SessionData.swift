//
//  SessionData.swift
//  Threads
//
//  Created by Igor Cova on 13/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//
import Foundation
import Alamofire

class SessionData {
    
    func wsSessionReqSave(phone: String, completion : (reqres: SessionReqRes, successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": "1234567890", "DID": MyDID, "Params": ["Phone": phone]]
        print (prms)
        Alamofire.request(.POST, "\(Threads)/SessionReq_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionary
                    let regRes = SessionReqRes(id: json!["ID"]!.int!, code: json!["Code"]!.string!, memberId: json!["MemberID"]!.int!)
          
                    completion(reqres: regRes, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    let regRes = SessionReqRes(id: 0, code: "", memberId: 0)
                    
                    completion(reqres: regRes, successful: false)
                }
        }
    }

    func wsSessionSave(sessionReqId: Int, completion : (mem: MemberEntryFields, isNew: Bool, successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": "1234567890", "DID": MyDID, "Params": ["SessionReq_ID": sessionReqId]]
        print (prms)
        Alamofire.request(.POST, "\(Threads)/Session_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionary
                    let mem = MemberEntryFields(id: json!["MemberID"]!.int!, sessionId: json!["SessionID"]!.string!)
                    let isNewMember = json!["IsNewMember"]!.bool!
                    completion(mem: mem, isNew: isNewMember, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    let mem = MemberEntryFields(id: 0, sessionId: "")
                    completion(mem: mem,  isNew: false, successful: false)
                }
        }
    }
}
