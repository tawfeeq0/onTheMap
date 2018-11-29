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
    static let HEADER_JSON = ["Accept":"application/json","Content-Type":"application/json"]
    static let SIGNUP_URL = "https://auth.udacity.com/sign-up"
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
