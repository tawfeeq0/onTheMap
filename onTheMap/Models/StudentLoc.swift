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
    
}
