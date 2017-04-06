//
//  RegisterViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 3/5/17.
//
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    let DatabaseRef = FIRDatabase.database().referenceFromURL("https://ridealong-a0f98.firebaseio.com/")
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBAction func handleCancel(sender: AnyObject) {
        self.performSegueWithIdentifier("backToLoginSegue", sender: nil)
    }
    
    @IBAction func handleContinue(sender: AnyObject) {
        let email = self.emailField.text!
        let password = self.passwordField.text!
        let confirmPassword = self.confirmPasswordField.text!
        let firstName = self.firstName.text!
        let lastName = self.lastName.text!
        
        if (email != "" && password == confirmPassword) {
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in if error == nil {
                //authenticates the user
                FIREmailPasswordAuthProvider.credentialWithEmail(email, password: password)
                self.dismissViewControllerAnimated(true, completion: nil)
                }
                guard let uid = user?.uid else {
                    return
                }
                let userReference = self.DatabaseRef.child("users").child(uid)
                let values = ["first-name" : firstName, "last-name" : lastName,  "email" :  email, "pic" : "", "car" : "", "seats" : "", "gender" : "", "class" : ""]
                
                userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error)
                        return
                    }
                })
            })
        }
        else if (email == "" || password == "") { //email is empty or passwords do not match
            let alert = UIAlertController(title: "Error", message: "Must complete email and password fields", preferredStyle: .Alert )
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (password != confirmPassword) {
            let alert = UIAlertController(title: "Error", message: "Passwords must be the same", preferredStyle: .Alert )
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (confirmPassword == "" ){
            let alert = UIAlertController(title: "Error", message: "Must confirm password", preferredStyle: .Alert )
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
