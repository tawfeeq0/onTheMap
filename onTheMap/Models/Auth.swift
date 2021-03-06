//
//  Udacity.swift
//  onTheMap
//
//  Created by Tawfeeq on 24/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit


class Auth {
    
    static var loginResponse : LoginResponse?
    static var signoutResponse : SignoutResponse?
    static var userId :String?
    static func login(email:String?,password:String?,callback:@escaping  (String?)->Void){
        var result:String?
        let userReq = LoginRequest(username: email!, password: password!)
        let jsonData = try! JSONEncoder().encode(userReq)
        
        HttpRequest.getData(from: Constants.LOGIN_URL, method: HttpMethod.POST, header: Constants.HEADER_LOGIN_JSON, hasCookie: false,body: jsonData) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    callback(HttpLoginStatus.NETWORK_ERROR.rawValue)
                }
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if(statusCode == 404){
                    result = HttpLoginStatus.AUTH_ERROR.rawValue
                }
                else {
                    loginResponse = try? JSONDecoder().decode(LoginResponse.self, from:data.subdata(in: (5..<data.count)) )
                    if let _ = loginResponse?.account?.key {
                        result =  HttpLoginStatus.SUCCESS.rawValue
                        userId = loginResponse?.account?.key
                    }
                    else{
                        result = HttpLoginStatus.DATA_ERROR.rawValue
                    }
                    
                }
            }
            
            DispatchQueue.main.async {
                callback(result)
            }
        }
        
        
    }
    
    static func logout(callback:@escaping  (String?)->Void){
        var result:String?
        
        HttpRequest.getData(from: Constants.LOGIN_URL, method: HttpMethod.DELETE, header:[:],hasCookie: true, body: nil) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    callback(HttpLoginStatus.NETWORK_ERROR.rawValue)
                }
                return
            }
            signoutResponse = try? JSONDecoder().decode(SignoutResponse.self, from:data.subdata(in: (5..<data.count)) )
            if let _ = signoutResponse?.session?.id {
                result =  HttpLoginStatus.SUCCESS.rawValue
            }
            else{
                result = HttpLoginStatus.DATA_ERROR.rawValue
            }
            DispatchQueue.main.async {
                callback(result)
            }
        }
        
        
    }
    
}



