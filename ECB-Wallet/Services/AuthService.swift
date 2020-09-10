//
//  AuthService.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import Foundation
import Alamofire
class AuthService {
    static let instan = AuthService()
    //MARK: Register
    func register(username:String,email:String, password:String, password_confirm:String, firebase_token:String, phoneCode:String, phoneNumber:String, completionHanler:@escaping(_ result:Bool, _ errorCode:Int?) -> Void){
        let headers:HTTPHeaders = [
            "content-length": "50",
            "content-type": "application/json; charset=utf-8"
        ]
        let body:[String:Any] = [
            "username":username,
            "password":password,
            "password_confirmation":password_confirm,
            "email":email,
            "firebase_token": firebase_token,
            "phone_code":phoneCode,
            "phone":phoneNumber
        ]
        AF.request("\(domain)api/auth/register", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil{
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                let errorCode = json["code"] as! Int
                completionHanler(true, errorCode)
            }else{
                completionHanler(false, nil)
            }
        }
    }
    //MARK: ResendConfirmCode
    func resendConfirmCode(firebase_Token:String, email:String, completionHanler:@escaping(_ result:Bool, _ errorCode:Int?) -> Void){
        let headers:HTTPHeaders = [
            "content-length": "50",
            "content-type": "application/json; charset=utf-8"
        ]
        let body:[String:Any] = [
            "firebase_token":firebase_Token,
            "email":email
        ]
        AF.request("\(domain)api/auth/resend-confirm-code", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil{
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                let errorCode = json["code"] as! Int
                completionHanler(true, errorCode)
            }else{
                completionHanler(false, nil)
            }
        }
    }
    //MARK: ConfirmAccount
    func confirmAccount(username:String, password:String, password_confirm:String, email:String, phoneCode:String, phoneNumber:String, code:String, completionHandler:@escaping(_ result:Bool, _ errorCode:Int?) -> Void){
        let headers:HTTPHeaders = [
            "content-length": "52",
            "content-type": "application/json; charset=utf-8"
        ]
        let body:[String:Any] = [
            "username":username,
            "password":password,
            "password_confirmation":password_confirm,
            "email":email,
            "code": code,
            "phone_code":phoneCode,
            "phone":phoneNumber
        ]
        AF.request("\(domain)api/auth/confirm-account", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil{
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                let errorCode = json["code"] as! Int
                completionHandler(true,errorCode)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    //MARK: - RequestCode
    func requestCode(email:String,completionHandler:@escaping(_ result:Bool, _ errorCode:Int?) -> Void){
        let headers:HTTPHeaders = [
            "content-length": "52",
            "content-type": "application/json; charset=utf-8"
        ]
        let body:[String:Any] = [
            "email":email
        ]
        AF.request("\(domain)api/auth/request-code", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil {
                guard let json = response.value as? Dictionary<String, AnyObject> else {return}
                let errorCode = json["code"] as! Int
                completionHandler(true, errorCode)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    //MARK: - Verify Code To Confirm forgot password
    func verifyCodeForgotPassword(code:String, email:String, completionHandler:@escaping(_ result:Bool, _ errorCode:Int?) -> Void){
        let headers:HTTPHeaders = [
            "content-length": "52",
            "content-type": "application/json; charset=utf-8"
        ]
        let body:[String:Any] = [
            "code":code,
            "email":email
        ]
        AF.request("\(domain)api/auth/verify-code", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil{
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                let errorCode = json["code"] as! Int
                completionHandler(true, errorCode)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    //MARK: - Reset password
    func resetPassword(email:String, code:String, password:String, passwordConfirm:String, completionHandler:@escaping(_ result:Bool, _ errorCode:Int?) -> Void){
        let headers:HTTPHeaders = [
            "content-length": "52",
            "content-type": "application/json; charset=utf-8"
        ]
        let body:[String:Any] = [
            "email":email,
            "code":code,
            "password":password,
            "password_confirmation":passwordConfirm
        ]
        AF.request("\(domain)api/auth/reset-password", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil {
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                let errorCode = json["code"] as! Int
                completionHandler(true, errorCode)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    //MARK: Login
    func login(firebaseToken:String, password:String, email:String, completionHandler:@escaping(_ result:Bool, _ errorCode:Int?) -> Void){
        let headers:HTTPHeaders = [
            "content-length": "587",
            "content-type": "application/json; charset=utf-8"
        ]
        let body:[String:Any] = [
            "firebase_token":firebaseToken,
            "password":password,
            "email":email
        ]
        AF.request("\(domain)api/auth/login", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil{
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                let errorCode = json["code"] as! Int
                let data = json["data"] as! [Dictionary<String,AnyObject>]
                for eachData in data{
                    guard let authToken = eachData["token"] as? String else {return}
                    defaults.set(authToken, forKey: TOKEN_KEY)
                }
                completionHandler(true,errorCode)
            }else{
                completionHandler(false, nil)
            }
        }
    }
    //MARK: Get me
    func getMe(authToken:String,completionHandler:@escaping(_ result:Bool, _ userInfo:UserInfo?, _ errorCode:Int?) -> Void){
        let headers:HTTPHeaders = [
            "content-length": "52",
            "content-type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(authToken)"
        ]
        AF.request("\(domain)api/auth/me", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { (response) in
            if response.error == nil{
                guard let json = response.value as? Dictionary<String,AnyObject> else {return}
                guard let errorCode = json["code"] as? Int else {return}
                var userInfo = UserInfo()
                let data = json["data"] as! [Dictionary<String,AnyObject>]
                for eachData in data {
                    guard let userName = eachData["username"] as? String else {return}
                    guard let email = eachData["email"] as? String else {return}
                    guard let phoneNumber = eachData["phone"] as? String else {return}
                    guard let phoneCode = eachData["phone_code"] as? String else {return}
                    guard let avatar = eachData["avatar"] as? String else {return}
                    guard let country = eachData["country"] as? Int else {return}
                    userInfo = UserInfo(userName: userName, email: email, phone: phoneNumber, phoneCode: phoneCode, avatar: avatar, country: country)
                }
                completionHandler(true, userInfo, errorCode)
            }else{
                completionHandler(false, nil, nil)
            }
        }
    }
}

