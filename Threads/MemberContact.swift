//
//  MemberContact.swift
//  Threads
//
//  Created by Igor Cova on 20/03/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation
import Contacts

class MemberContact {
    //Здесь будет вычисляться то, какие контакты будут в массиве и буквы в линии.
    var allConacts = NSMutableArray()
    var сontactsByAlphabet = [stContact]()
    let exceptionNumber = ["79264308272", "79253396965", "79164913669", "79806406454", "79672288506", "79258709392"]
    var lineAlphabet = [String]()
    
    func AlphabetDrawing() {
        
        // Запрашиваем все контакты
        requestForAllContacts()
        
        //Крнтакты лежат в массиве по алфивиту, теперь нужно составить AlphabetDrawing
        // сontactsByAlphabet.append(ContactsByAlphabet(letter: "TOP", contacts: []))
        for contact in allConacts {
            let nameContact : String = contact.givenName ?? "#"
            var isHave = false
                
            for index in 0 ..< сontactsByAlphabet.count {
                var nc = "#"
                if !nameContact.isEmpty {
                    nc = nameContact[0]
                }
                    
                if сontactsByAlphabet[index].letter == nc {
                    isHave = true
                    break
                }
            }
                
            if isHave == false {
                сontactsByAlphabet.append(stContact(letter: nameContact[0], contacts: []))
            }
        }
    }
    
    private func topSection() {
        сontactsByAlphabet.insert(stContact(letter: "TOP", contacts: []), atIndex: 0)
        for index in 1 ..< сontactsByAlphabet.count {
            for var y in 0...сontactsByAlphabet[index].contacts.count {
                let contact = сontactsByAlphabet[index].contacts[y]
                
                for number in exceptionNumber {
                    for lableNumber in contact.phoneNumbers {
                        if number == stringNumber((lableNumber.value as! CNPhoneNumber).stringValue)  {
                            сontactsByAlphabet[0].contacts.append(contact)
                            сontactsByAlphabet[index].contacts.removeAtIndex(y)
                            y -= 1
                            //print("Успешно")
                        }
                    }
                }
            }
        }
        сontactsByAlphabet[0].contacts.sortInPlace({$0.givenName ?? "#" < $1.givenName ?? "#"})
        cleaner()
    }
    
    private func cleaner() {
        for var index in 0...сontactsByAlphabet.count {
            if сontactsByAlphabet[index].contacts.isEmpty {
                сontactsByAlphabet.removeAtIndex(index)
                index -= 1
            }
        }
    }
    
    func stringNumber(number: String) -> String {
        let stringArray = number.componentsSeparatedByCharactersInSet(
            NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        let newString = stringArray.joinWithSeparator("")
        
        return newString
    }
    
    func contactsByAlphabetDrawing() -> [stContact] {
        AlphabetDrawing()
        for contact in allConacts {
            let nameContact = contact.givenName as String
            for index in 0 ..< сontactsByAlphabet.count {
                if nameContact[0] == сontactsByAlphabet[index].letter {
                    сontactsByAlphabet[index].contacts.append(contact as! CNContact)
                }
            }
        }
    
        self.topSection()
        
        return сontactsByAlphabet
    }
    
    private func requestForAllContacts() {
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactUrlAddressesKey, CNContactImageDataKey]
        let store = CNContactStore()
        
        do {
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            try store.enumerateContactsWithFetchRequest(request) {
                contact, _ in
                self.allConacts.addObject(contact)
            }
        }
        catch {
        }
    }
}
