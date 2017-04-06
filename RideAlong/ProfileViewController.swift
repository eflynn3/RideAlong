//
//  ProfileViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 3/28/17.
//
//

import Foundation
import UIKit
import Firebase

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let storageRef = FIRStorage.storage().reference()
    let databaseRef = FIRDatabase.database().reference()
    
    @IBOutlet weak var classYearText: UITextField!
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var carText: UITextField!
    @IBOutlet weak var seatsText: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBAction func confirmButton(sender: AnyObject) {
        let uid = FIRAuth.auth()?.currentUser!.uid
        databaseRef.child("users").child(uid!).updateChildValues(["car" : carText.text!, "class" : classYearText.text!, "gender" : genderText.text!, "seats" : seatsText.text!])
        saveChanges()
        self.performSegueWithIdentifier("backToLogin", sender: nil)

    }
    
    
    @IBAction func pickImage(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpProfile()

        // Do any additional setup after loading the view.
    }
    
    func setUpProfile() {
        profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        let uid = FIRAuth.auth()?.currentUser?.uid
        databaseRef.child("users").child(uid!).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
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
    func logout(){
        let storyboard = UIStoryboard(name: "Login Page", bundle: nil)
        let loginViewController = storyboard.instantiateViewControllerWithIdentifier("Login")
        self.presentViewController(loginViewController, animated: true, completion : nil)
    }
    
    func imagePickerController(picker : UIImagePickerController, didFinishPickingImage image : UIImage, editingInfo : [String: AnyObject]?){
        profilePic.image = image
        dismissViewControllerAnimated(true, completion: nil)
        var data = NSData()
        data = UIImagePNGRepresentation(profilePic.image!)!
        let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("profilePic")"
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpg"
        self.storageRef.child(filePath).putData(data, metadata: metadata) {
            (metadata, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            else {
                let downloadURL = metadata!.downloadURL()!.absoluteString
                self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["pic": downloadURL])

            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveChanges() {
        let ImageName = NSUUID().UUIDString
        let storedImage = storageRef.child("profile_images").child(ImageName)
        if let uploadData = UIImagePNGRepresentation(self.profilePic.image!){
            storedImage.putData(uploadData, metadata: nil, completion: { (error, metadata) in
                if error != nil {
                    print(error)
                    return
                }
                storedImage.downloadURLWithCompletion({(url, error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    if let urlText = url?.absoluteString{
                        self.databaseRef.child("users").child((FIRAuth.auth()?.currentUser!.uid)!).updateChildValues(["pic" : "erin"], withCompletionBlock: { (error, ref) in
                            if error != nil {
                                print(error)
                                return
                            }
                        }
                    )}
                }
            )}
            )}
    }
}