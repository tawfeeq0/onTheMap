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
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
}
