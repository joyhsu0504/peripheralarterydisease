//
//  LoginViewController.swift
//  PAD
//
//  Created by Joy Hsu on 10/17/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
//import FirebaseAnalytics

class LoginViewController: UIViewController {
    
    let loginToList = "LoginToList"
    
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let ref = FIRDatabase.database().reference(withPath: "users")
        //let rootRef = FIRDatabase.database().reference(fromURL:"https://padproject-d9f07.firebaseio.com/")
        //FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
        //    if user != nil {
        //        self.performSegue(withIdentifier: self.loginToList, sender: nil)
        //    }
        //}
        //FIRApp.configure()
//        let reference = FIRDatabase.database().reference()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguehere" {
            
            print("segue-ing")
            
        }
    }
    
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        let reference = FIRDatabase.database().reference()
        reference.child("users").child(textFieldLoginEmail.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? String
            //let username = value?["username"] as? String ?? ""
            //self.textFieldLoginEmail.text = value
            if value == self.textFieldLoginPassword.text! {
                //add segue
                self.performSegue(withIdentifier: "seguehere", sender: nil)
                self.label.text = ""
            } else {
                self.label.text = "Invalid credentials"
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        //reference.child("users").orderByChild("").equalTo("Alex").on("child_added",  ...)

        //FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
                               //password: textFieldLoginPassword.text!)
    }
    
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        let reference = FIRDatabase.database().reference()
        reference.child("users").child(textFieldLoginEmail.text!).setValue(textFieldLoginPassword.text!)
        self.label.text = "Please login"
            //.setValue([textFieldLoginEmail.text!: textFieldLoginPassword.text!])
        //reference.childByAutoId().setValue(passwordField.text, forKey: emailField.text!)
//                                        FIRAuth.auth()!.createUser(withEmail: emailFreield.text!,
//                                                                   password: passwordField.text!) { user, error in
//                                                                    if error == nil {
//                                                                        FIRAuth.auth()!.signIn(withEmail: self.textFieldLoginEmail.text!,
//                                                                                               password: self.textFieldLoginPassword.text!)
//                                                                    }
//                                        }
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
