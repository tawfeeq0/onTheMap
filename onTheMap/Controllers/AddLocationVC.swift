//
//  AddLocationVC.swift
//  onTheMap
//
//  Created by Tawfeeq on 30/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationVC: UIViewController {

    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var urlTF: UITextField!
    @IBOutlet weak var findButton: UIButton!
    var activityIndicator =  UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        cityTF.delegate = self
        urlTF.delegate = self
        disableButton(true)
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        addRedius(component: cityTF)
        addRedius(component: urlTF)
        addRedius(component: findButton)
    }
    
    func disableButton(_ disable:Bool){
        if disable{
            findButton.isEnabled = false
            findButton.alpha = 0.5
        }
        else {
            findButton.isEnabled = true
            findButton.alpha = 1.0
        }
    }
    

    @IBAction func showLocation(_ sender: Any) {
        loadingIndicator(true)
        let geocoder = CLGeocoder()
        if let text = cityTF.text {
            geocoder.geocodeAddressString(text) { (placeMarks, error) in
                self.loadingIndicator(false)
                guard let mark = placeMarks?.first else {
                    self.showAlert("location entered doesn't exist")
                    return
                }
                
                self.performSegue(withIdentifier: "showLocation", sender: (mark,self.urlTF.text))
            }
        }
        
        
        
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocation", let vc = segue.destination as? ShowLocationVC {
            vc.param = (sender as! (CLPlacemark?,String?)?)
        }
    }

}

extension AddLocationVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty{
            disableButton(true)
        } else {
            disableButton(false)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func loadingIndicator(_ show:Bool) {
        if(show){
            findButton.isEnabled = false
            findButton.alpha = 0.5
            activityIndicator.center = CGPoint(x: findButton.bounds.size.width/2, y: findButton.bounds.size.height/2)
            findButton.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        else{
            findButton.isEnabled = true
            findButton.alpha = 1.0
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
}
