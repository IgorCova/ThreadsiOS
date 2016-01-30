//
//  MemberData.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

class MemberData {
    private var member: Member?
    
    func wsGetMemberInstance(id: Int, completion : (memberInstance: Member?, successful: Bool) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST("\(Threads)/Member_ReadInstance",
            parameters: ["Session": "1234567890", "DID" : "CovaPhone", "Params": ["MemberID": id]]
            ,success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                //print("JSON: " + responseObject.description)
                let memberData = JSON(responseObject)["Data"].dictionaryValue
                let mem = Member(
                     id: memberData["ID"]!.int!
                    ,name: memberData["Name"]!.string!
                    ,userName: memberData["UserName"]!.string!
                    ,fullName: memberData["FullName"]!.string!
                    ,about: memberData["About"]!.string!)
                
                completion(memberInstance: mem, successful: true)
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError!) in
                print("Error: " + error.localizedDescription)
                completion(memberInstance: self.member, successful: false)
        })
    }
}