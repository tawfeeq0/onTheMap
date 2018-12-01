//
//  Codables.swift
//  onTheMap
//
//  Created by Tawfeeq on 27/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit
import MapKit


struct Session : Codable {
    var id : String?
    var expiration : String?
}

struct LoginRequest : Codable{
    var udacity : Udacity?
    struct Udacity : Codable {
        var username : String?
        var password : String?
    }
    init(username:String,password:String) {
        self.udacity = Udacity(username: username, password: password)
    }
}

struct LoginResponse : Codable{
    var account : Account?
    var session : Session?
    var result : String?
    struct Account : Codable {
        var registered : Bool?
        var key : String?
    }
}

struct SignoutResponse:Codable{
    var session:Session?
}

struct StudentsLocResponse:Codable{
    var results:[Result]?
    struct Result : Codable {
        var uniqueKey : String?
        var firstName : String?
        var lastName : String?
        var mediaURL : String?
        var latitude : Double?
        var longitude : Double?
    }
}

struct PublicUserResponse:Codable{
    var key : String?
    var first_name : String?
    var last_name : String?
    var nickname : String?
}

struct AddLocationRequest:Codable {
    var uniqueKey:String?
    var firstName:String?
    var lastName:String?
    var mapString:String?
    var mediaURL:String?
    var latitude:Double?
    var longitude:Double?
}

struct AddLocationResponse:Codable {
    var createdAt:String?
    var objectId:String?
}


