//
//  CountryData.swift
//  Threads
//
//  Created by Igor Cova on 13/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation
import Alamofire


class CountryData {
    
    func wsGetCountryReadDict(completion : (countryDict: [Country], successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID]
        Alamofire.request(.POST, "\(Threads)/Country_ReadDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    var cDict = [Country]()
                    for ctr in json {
                        let country = Country(
                             code: ctr["Code"].string!
                            ,name: ctr["Name"].string!)
                        cDict.append(country)
                    }
                    completion(countryDict: cDict, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(countryDict:[], successful: false)
                }
        }
    }
    
    
}