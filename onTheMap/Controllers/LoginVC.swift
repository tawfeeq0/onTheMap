//
//  ViewController.swift
//  onTheMap
//
//  Created by Tawfeeq on 24/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var signUpButton : UIButton!
    var alert : UIAlertController?
    var activityIndicator =  UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        emailTF.delegate = self
        passwordTF.delegate = self
        disableLoginButton(true)
        [emailTF, passwordTF].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })

        
    }
    
    func updateUI(){
        addRedius(component: emailTF)
        addRedius(component: passwordTF)
        addRedius(component: loginButton)
    }
    func disableLoginButton(_ disable:Bool){
        if disable{
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
        }
        else {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        }
    }
    
    @IBAction func login(){
        self.view.endEditing(true)
        loadingIndicator(true)
        Auth.login(email: emailTF.text!, password: passwordTF.text!) { (response) in
            self.loadingIndicator(false)
            guard let response = response else {
                return
            }
            if response == HttpLoginStatus.SUCCESS.rawValue {
                self.performSegue(withIdentifier: "login", sender: nil)
                return
            }
            else {
                self.showAlert(response)
                return
            }
        }
    }
    
    @IBAction func signup(){
        openURL(url: Constants.SIGNUP_URL)
    }

}

extension LoginVC : UITextFieldDelegate{
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard let email = emailTF.text, !email.isEmpty,let pass = passwordTF.text, !pass.isEmpty else {
                disableLoginButton(true)
                return
        }
        disableLoginButton(false)
    }
    
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if emailTF.text!.isEmpty || passwordTF.text!.isEmpty{
            disableLoginButton(true)
        } else {
            disableLoginButton(false)
        }
        return true
    }
    */
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
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
            activityIndicator.center = CGPoint(x: loginButton.bounds.size.width/2, y: loginButton.bounds.size.height/2)
            loginButton.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        else{
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}



