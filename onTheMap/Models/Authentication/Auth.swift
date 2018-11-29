//
//  Udacity.swift
//  onTheMap
//
//  Created by Tawfeeq on 24/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit


class Auth {
    
    static var authResponse : UserResponse?
    
    static func login(email:String?,password:String?,callback:@escaping  (String?)->Void){
        var result:String?
        let userReq = UserRequest(username: email!, password: password!)
        let jsonData = try! JSONEncoder().encode(userReq)
        
        HttpRequest.getData(from: Constants.LOGIN_URL, method: HttpMethod.POST, header: Constants.HEADER_JSON, body: jsonData) { (data, response, error) in
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
                    authResponse = try? JSONDecoder().decode(UserResponse.self, from:data.subdata(in: (5..<data.count)) )
                    if let _ = authResponse?.account?.key {
                        result =  HttpLoginStatus.SUCCESS.rawValue
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
}



