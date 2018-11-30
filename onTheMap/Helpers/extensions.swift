//
//  extensions.swift
//  onTheMap
//
//  Created by Tawfeeq on 24/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat){
        self.init(red:r/255,green:g/255,blue:b/255,alpha:1)
    }
}

extension UIViewController{
    func logout(){
        Auth.logout(){ (response) in
            guard let response = response else {
                return
            }
            if response == HttpLoginStatus.SUCCESS.rawValue {
                self.performSegue(withIdentifier: "logout", sender: nil)
                return
            }
            else {
                return
            }
        }
    }
    
    
}
