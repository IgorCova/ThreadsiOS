//
//  MemberData.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//
import Foundation
import CoreData
import Alamofire

class MemberData {
    func wsGetMemberInstance(id: Int, completion : (memberInstance: Member?, successful: Bool) -> Void) {
        let prms : [String : AnyObject]  = ["Session": "1234567890", MyDID : "CovaPhone", "Params": ["MemberID": id]]
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
        let prms : [String : AnyObject] = ["Session": "1234567890", "DID" : MyDID, "Params": ["Member": jcmem]]
        Alamofire.request(.POST, "\(Threads)/Member_Save", parameters: prms, encoding: .JSON)
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
    
    func getMyMemberID() -> Int {
        var myMemberID: Int = 0
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "MemberEntity")
        
        do {
            let fetchResult = try context.executeFetchRequest(fetchRequest) as! [Log]
            
            if fetchResult.isEmpty {
                
            } else {
                myMemberID = (fetchResult[0].memberId as! Int)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return myMemberID
    }
    
    func saveMemberEntry (member: MemberEntryFields) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let newMember = NSEntityDescription.insertNewObjectForEntityForName("Log", inManagedObjectContext: context) as! Log
        
        newMember.memberId = NSNumber(integer: member.id)
        newMember.sessionId = member.sessionId
        
        do {
            try context.save()
        } catch {
            
        }
    }
}