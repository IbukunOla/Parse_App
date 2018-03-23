//
//  ViewController.swift
//  Charse
//
//  Created by Ibukun on 2/21/18.
//  Copyright © 2018 Ibukun. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    let emptyAlertController = UIAlertController(title: "Empty", message: "Username or Password field is empty", preferredStyle: .alert)
    let errorAlertController = UIAlertController(title: "Error", message: "Your username or passsword was incorrect", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        emptyAlertController.addAction(OKAction)
        let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            //means there was an error in logging
        }
        errorAlertController.addAction(errorAction)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func login(_ sender: Any) {
        let username = userField.text ?? ""
        let password = passField.text ?? ""
        
        if username.isEmpty || password.isEmpty {
            present(emptyAlertController, animated: true)
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.present(self.errorAlertController, animated: true)
            } else {
                print("User Logged In")
            
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = userField.text
        newUser.password = passField.text
        
        newUser.signUpInBackground { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered")
                
            }
        }
    }
    
}

