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
    
    func wsSessionReqSave(sessionReq: SessionReq, completion : (code : String, successful: Bool) -> Void) {
        
        let jsSessionReq = ["DID": sessionReq.dID, "Phone": sessionReq.phone]
        
        let prms = ["Session": "1234567890", "DID": "CovaPhone", "Params": ["SessionReq": jsSessionReq]]
        Alamofire.request(.POST, "\(Threads)/SessionReq_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionary
                    let code = json!["Code"]!.string!
                    completion(code: code, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(code: "", successful: false)
                }
        }
    }


}
