//
//  CommunityData.swift
//  Threads
//
//  Created by Igor Cova on 17/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import Foundation

class CommunityData {
    
    private var communities = [Community]()
    
    func getNameById(id: Int) -> String {
        var commName: String?
        if communities.count == 0 {
            loadDefData()
        }
        if id >= 0 && id < communities.count {
            if let i = communities.indexOf({$0.id == id}) {
                commName = communities[i].name
            } else {
                commName = "Non"
            }
        }

       // commName = "thread"
        
        return commName!
    }
    
    func getLogoById(id: Int) -> String {
        var commLogo: String?
        if communities.count == 0 {
            loadDefData()
        }
        
        if id >= 0 && id < communities.count {
            if let i = communities.indexOf({$0.id == id}) {
                commLogo = communities[i].linkToImage
            } else {
                commLogo = "Non"
            }
        }

        return commLogo!
    }
    
    func loadDefData() {
        let c1 = Community(id: 1, name: "Digital Tectonics", linkToImage: "ComLogos/DigTec.jpg", inMyList: true, countMembers: "1145")
        let c2 = Community(id: 2, name: "Major Mafia", linkToImage: "ComLogos/MajorMafia.png", inMyList: true, countMembers: "214")
        let c3 = Community(id: 3, name: "Mr. Freeman", linkToImage: "ComLogos/mF.png", inMyList: true, countMembers: "1098")
        let c4 = Community(id: 4, name: "Run Foundation", linkToImage: "ComLogos/RunFoundation.png", inMyList: false, countMembers: "310")
        let c5 = Community(id: 5, name: "Threads", linkToImage: "ComLogos/thread.png", inMyList: false, countMembers: "18017")
        let c6 = Community(id: 6, name: "GitHub news", linkToImage: "ComLogos/DigTec.jpg", inMyList: true, countMembers: "1145")
        let c7 = Community(id: 7, name: "HubraHubr", linkToImage: "ComLogos/MajorMafia.png", inMyList: true, countMembers: "214")
        let c8 = Community(id: 8, name: "Franky Show", linkToImage: "ComLogos/mF.png", inMyList: true, countMembers: "1098")
        let c9 = Community(id: 9, name: "Adventures", linkToImage: "ComLogos/RunFoundation.png", inMyList: false, countMembers: "310")
        
        self.communities.append(c1)
        self.communities.append(c2)
        self.communities.append(c3)
        self.communities.append(c4)
        self.communities.append(c5)
        self.communities.append(c6)
        self.communities.append(c7)
        self.communities.append(c8)
        self.communities.append(c9)
    }
}