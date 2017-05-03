//
//  LoginPageViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 3/5/17.
//
//

import UIKit
import FirebaseAuth

class LoginPageViewController: UIViewController {
   
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func handleLogin(sender: AnyObject) {
        let email = self.emailField.text!
        let password = self.passwordField.text!
        
        if (email != "" && password != ""){
            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error ) in
                if error == nil {
                    self.performSegueWithIdentifier("toNewsFeed", sender: nil)
                }
                else {
                    print(error)
                }
            })
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Must complete email and password fields", preferredStyle: .Alert )
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
