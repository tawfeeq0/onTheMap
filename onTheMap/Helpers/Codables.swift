//
//  Codables.swift
//  onTheMap
//
//  Created by Tawfeeq on 27/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit

struct UserResponse : Codable{
    var account : Account?
    var session : Session?
    var result : String?
    struct Account : Codable {
        var registered : Bool?
        var key : String?
    }
    struct Session : Codable {
        var id : String?
        var expiration : String?
    }
}

struct UserRequest : Codable{
    var udacity : Udacity?
    
    struct Udacity : Codable {
        var username : String?
        var password : String?
    }
    
    init(username:String,password:String) {
        self.udacity = Udacity(username: username, password: password)
    }
}
