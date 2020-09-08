//
//  IntroductionService.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/7/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import Foundation
import Alamofire
class IntroductionService{
    static let instant = IntroductionService()
    func getIntroductionPage(completion:@escaping(_ introPages:[introductionModel]) -> Void) {
        var introPages = [introductionModel]()
        let headers:HTTPHeaders = [
            "content-type": "application/json; charset=utf-8"
        ]
        AF.request("\(domain)api/page/introductions", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil{
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                let datas = json["data"] as! [Dictionary<String,AnyObject>]
                for data in datas {
                    let title = data["title"] as! String
                    let subTitle = data["sub_title"] as! String
                    let imageName = data["image"] as! String
                    let imageUrl = "\(domain)public/\(imageName)"
                    let content = data["content"] as! String
                    let introPage = introductionModel(title: title, subtitle: subTitle, imageUrl: imageUrl, content: content)
                    introPages.append(introPage)
                }
                completion(introPages)
            }else{
                print("Get all introduction page fail")
            }
        }
    }
}
