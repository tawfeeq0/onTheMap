//
//  HttpRequest.swift
//  onTheMap
//
//  Created by Tawfeeq on 24/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit

class HttpRequest{
    
    static func getData(from url: String,method:HttpMethod,header:[String:String],body:Data, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HttpMethod.POST.rawValue
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = body
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}


