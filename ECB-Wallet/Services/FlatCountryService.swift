//
//  FlatCountryService.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/8/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import Foundation
import Alamofire
class FlatCountryService {
    static let instant = FlatCountryService()
    var listFlagCountry = [flag]()
    var curentLocation:location = location()
    
    func getAllFlatCountry(completionHanler:@escaping(_ success:Bool, _ curentLocation:location, _ listFlagCountry:[flag]) -> ()) {
        //Get current countryCode
        let locale: NSLocale = NSLocale.current as NSLocale
        let countryCode: String? = locale.countryCode
        let headers:HTTPHeaders = [
            "content-length": "21480",
            "content-type": "application/json; charset=utf-8"
        ]
        guard let locationCode = countryCode else {return}
        AF.request("\(domain)api/country?location=\(locationCode)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil {
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                let errCode = json["code"] as! Int
                defaults.set(errCode, forKey: errorCode) //save value of errorCode into userDeafault
                let data = json["data"] as! [Dictionary<String,AnyObject>]
                for eachData in data {
                    //
                    let locations = eachData["location"] as! Dictionary<String, AnyObject>
                    let countryName = locations["name"] as! String
                    let phoneCode = locations["phone_code"] as! String
                    let flatImage = locations["flag"] as! String
                    let flatImageUrl = "\(domain)public/flag/\(flatImage)"
                    self.curentLocation = location(imageUrl: flatImageUrl, countryName: countryName, phoneCode: phoneCode)
                    //
                    let countries = eachData["countries"] as! [Dictionary<String,AnyObject>]
                    for country in countries {
                        let countryName = country["name"] as! String
                        let phoneCode = country["phone_code"] as! String
                        let flagImage = country["flag"] as! String
                        let flagImageUrl = "\(domain)public/flag/\(flagImage)"
                        let flagCountry = flag(imageUrl: flagImageUrl, countryName: countryName, phoneCode: phoneCode)
                        self.listFlagCountry.append(flagCountry)
                    }
                }
                completionHanler(true, self.curentLocation, self.listFlagCountry)
            }else{
                completionHanler(false,self.curentLocation,self.listFlagCountry)
            }
        }
    }
}
