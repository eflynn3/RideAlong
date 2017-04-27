//
//  CurrentProfileViewController.swift
//  
//
//  Created by Erin Flynn on 4/6/17.
//
//

import UIKit
import Firebase

class CurrentProfileViewController: UIViewController {
    
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    @IBAction func newsFeed(sender: AnyObject) {
        self.performSegueWithIdentifier("goToNewsFeed", sender: nil)
    }
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpProfile()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func upload() {
        let uid = FIRAuth.auth()?.currentUser!.uid
        let filePath = "\(uid!)/\("profilePic")"
        let fileData = NSData() // get data...
        let storageRef = FIRStorage.storage().reference().child(filePath)
        storageRef.putData(fileData).observeStatus(.Success) { (snapshot) in
            // When the image has successfully uploaded, we get it's download URL
            let downloadURL = snapshot.metadata?.downloadURL()?.absoluteString
            // Write the download URL to the Realtime Database
            self.databaseRef.child(filePath).setValue(downloadURL)
        }
    }
    
    func setUpProfile() {
        profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        let uid = FIRAuth.auth()?.currentUser?.uid ?? "nil"
        databaseRef.child("users").child(uid).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                let first = dict["first-name"]?.uppercaseString
                let last = dict["last-name"]?.uppercaseString
                self.nameLabel.text! = first! + " " + last!
                let classYear = dict["class"]?.uppercaseString
                let gender = dict["gender"]?.uppercaseString
                self.infoLabel.text! = classYear! + " | " + gender!
                if let profileImageURL = dict["pic"] as? String{
                    let url = NSURL(string: profileImageURL)
                    NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) in
                        if error != nil {
                            print(error)
                            return
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.profilePic?.image = UIImage(data: data!)
                        }
                    }).resume()
                }
            }
        })
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
