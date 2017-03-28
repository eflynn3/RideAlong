//
//  ProfileViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 3/28/17.
//
//

import UIKit
import Firebase
import FirebaseDatabase


class ProfileViewController: UIViewController {

    @IBOutlet weak var classYearText: UITextField!
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var carText: UITextField!
    @IBOutlet weak var seatsText: UITextField!
    
    @IBAction func confirmButton(sender: AnyObject) {
        let userGender = self.genderText.text!
        let userClassYear = self.classYearText.text!
        let userCar = self.carText.text!
        let userSeats = self.seatsText.text!


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
