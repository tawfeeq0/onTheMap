//
//  Constants.swift
//  onTheMap
//
//  Created by Tawfeeq on 27/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit

struct Constants {
    static let LOGIN_URL = "https://www.udacity.com/api/session"
    static let STUDENTS_LOC_URL = "https://parse.udacity.com/parse/classes/StudentLocation"
    static let HEADER_LOGIN_JSON = ["Accept":"application/json","Content-Type":"application/json"]
    static let HEADER_AUTH = ["X-Parse-Application-Id":"QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr",
                              "X-Parse-REST-API-Key":"QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"]
    static let SIGNUP_URL = "https://auth.udacity.com/sign-up"
    static let PUBLIC_URL = "https://www.udacity.com/api/users/"
}

enum HttpLoginStatus : String {
    case SUCCESS = "SUCCESS"
    case NETWORK_ERROR = "Network not avaiable"
    case AUTH_ERROR = "Username or password are incorrect"
    case DATA_ERROR = "Login information are corrupted."
}

enum HttpMethod : String{
    case GET,POST,PUT,DELETE
}
struct StudentLocParams{
    var limit:Int
    var skip:Int?
    var order:String?
    var search:String?
    
    func getUrl() -> String{
        var url =  "\(Constants.STUDENTS_LOC_URL)?limit=\(limit)"
        if let skip = skip {
            url += "&skip=\(skip)"
        }
        if let order = order {
            url += "&order=\(order)"
        }
        if let search = search {
            url += "&where=\(search)"
        }
        return url
        
    }
}
