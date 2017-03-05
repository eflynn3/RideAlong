//
//  RegisterViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 3/5/17.
//
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func handleCancel(sender: AnyObject) {
        self.performSegueWithIdentifier("backToLoginSegue", sender: nil)
    }
    
    @IBAction func handleContinue(sender: AnyObject) {
        let email = self.emailField.text!
        let password = self.passwordField.text!
        let confirmPassword = self.confirmPasswordField.text!
        
        if (email != "" && password == confirmPassword) {
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in if error == nil {
                //authenticates the user
                FIREmailPasswordAuthProvider.credentialWithEmail(email, password: password)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                print(error)
                }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
