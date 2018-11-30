//
//  HttpRequest.swift
//  onTheMap
//
//  Created by Tawfeeq on 24/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit

class HttpRequest{
    
    static func getData(from url: String,method:HttpMethod,header:[String:String],hasCookie:Bool,body:Data?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        if(body != nil){
            request.httpBody = body
        }
        if(hasCookie){
            var xsrfCookie: HTTPCookie? = nil
            let sharedCookieStorage = HTTPCookieStorage.shared
            for cookie in sharedCookieStorage.cookies! {
                if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
            }
            if let xsrfCookie = xsrfCookie {
                request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            }
        }
        
        
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}


