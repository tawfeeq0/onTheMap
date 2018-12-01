//
//  StudentLoc.swift
//  onTheMap
//
//  Created by Tawfeeq on 30/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit
class StudentLoc{
    static var studentsLocResponse : StudentsLocResponse?
    static var publicUserResponse : PublicUserResponse?
    static var addLocationResponse : AddLocationResponse?
    static func getLocationList(params:StudentLocParams,callback:@escaping  (String?,StudentsLocResponse?)->Void){
        var message:String?
        
        HttpRequest.getData(from: params.getUrl(), method: HttpMethod.GET, header:Constants.HEADER_AUTH,hasCookie: false, body: nil) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    callback(HttpLoginStatus.NETWORK_ERROR.rawValue,studentsLocResponse)
                }
                return
            }
            studentsLocResponse = try? JSONDecoder().decode(StudentsLocResponse.self, from:data)
            if let _ = studentsLocResponse?.results {
                message =  HttpLoginStatus.SUCCESS.rawValue
            }
            else{
                message = HttpLoginStatus.DATA_ERROR.rawValue
            }
            DispatchQueue.main.async {
                callback(message,studentsLocResponse)
            }
        }
        
    }
    
    static func getPublicProfile(callback:@escaping  (String,PublicUserResponse?)->Void){
        var message:String=""
        
        HttpRequest.getData(from: Constants.PUBLIC_URL+Auth.userId!, method: HttpMethod.GET, header:[:],hasCookie: false, body: nil) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    callback(HttpLoginStatus.NETWORK_ERROR.rawValue,publicUserResponse)
                }
                return
            }
            publicUserResponse = try? JSONDecoder().decode(PublicUserResponse.self, from:data.subdata(in: (5..<data.count)) )
            if let _ = publicUserResponse?.key {
                message =  HttpLoginStatus.SUCCESS.rawValue
            }
            else{
                message = HttpLoginStatus.DATA_ERROR.rawValue
            }
            DispatchQueue.main.async {
                callback(message,publicUserResponse)
            }
        }
        
    }
    
    static func addLocation(info:AddLocationRequest,callback:@escaping  (String?)->Void){
        var result:String?
        let jsonData = try! JSONEncoder().encode(info)
        var combinedHeader = Constants.HEADER_AUTH
        combinedHeader += Constants.HEADER_LOGIN_JSON
        HttpRequest.getData(from: Constants.STUDENTS_LOC_URL, method: HttpMethod.POST, header: combinedHeader, hasCookie: false,body: jsonData) { (data, response, error) in
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
                    addLocationResponse = try? JSONDecoder().decode(AddLocationResponse.self, from:data)
                    if let _ = addLocationResponse?.objectId {
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
