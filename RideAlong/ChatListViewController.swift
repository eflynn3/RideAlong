//
//  ChatListViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/25/17.
//
//

import UIKit

import Firebase



enum Section: Int {
    
    case createNewChatSection = 0
    
    case currentChatsSection
    
}



class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    // MARK: Properties
    
    var senderDisplayName: String? // 1
    
    var newChatTextField: UITextField? // 2
    
    private var chats: [Chat] = [] // 3
    
    
    
    /*func numberOfSections(tableView: UITableView) -> Int {
     
     return 2 // 1
     
     }*/
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 2
        
        if let currentSection: Section = Section(rawValue: section) {
            
            switch currentSection {
                
            case .createNewChatSection:
                
                return 1
                
            case .currentChatsSection:
                
                return chats.count
                
            }
            
        } else {
            
            return 0
            
        }
        
    }
    
    
    
    // 3
    
    //override func tableView( tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChatSection.rawValue ? "NewChat" : "ExistingChat"
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, forIndexPath: indexPath)
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: NSIndexPath) //got rid of withIdentifier -- ok??
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath)
        
        if (indexPath as NSIndexPath).section == Section.createNewChatSection.rawValue {
            
            if let createNewChatCell = cell as? CreateChatCell {
                
                newChatTextField = createNewChatCell.newChatNameField
                
            }
            
        } else if (indexPath as NSIndexPath).section == Section.currentChatsSection.rawValue {
            
            cell.textLabel?.text = chats[(indexPath as NSIndexPath).row].name
            
        }
        
        
        
        return cell
        
    }
    
    override func viewDidAppear( animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        
        chats.append(Chat(id: "1", name: "Channel1"))
        
        chats.append(Chat(id: "2", name: "Channel2"))
        
        chats.append(Chat(id: "3", name: "Channel3"))
        
        //self.tableView.reloadData()
        
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