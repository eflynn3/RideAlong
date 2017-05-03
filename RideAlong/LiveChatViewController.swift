//
//  LiveChatViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/26/17.
//
//

import Firebase
import JSQMessagesViewController

class LiveChatViewController: JSQMessagesViewController {

    var userRef: FIRDatabaseReference?
    var messRef: FIRDatabaseReference?
    var itemRef: FIRDatabaseReference?
    var chatUser: String!
    var count: Int!
    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    private var newMessageRefHandle: FIRDatabaseHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBar()
        self.topContentAdditionalInset = 50
        observeMessages()

        self.senderDisplayName = "Erin"
        self.senderId = FIRAuth.auth()?.currentUser?.uid
        self.userRef = FIRDatabase.database().reference()

        self.messRef = self.userRef!.child("users").child(self.senderId!).child("chats")
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        //observeMessages()
        
        /*// messages from someone else
        addMessage(withId: "foo", name: "Mr.Bolt", text: "I am so fast!")
        // messages sent from local sender
        addMessage(withId: senderId, name: "Me", text: "I bet I can run faster than you!")
        addMessage(withId: senderId, name: "Me", text: "I like to run!")
        // animates the receiving of a new message on the view
        finishReceivingMessage()*/
        // Load the sample data.
    }
    
    func addNavBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width + 40, height:50)) // Offset by 20 pixels vertically to take the status bar into account
        
        //navigationBar.barTintColor = UIColor.blackColor()
        navigationBar.barTintColor = UIColor.whiteColor()
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Erin Turley"
        
        // Create left and right button for navigation item
        //let leftButton =  UIBarButtonItem(title: "Back", target: self, action: #selector(btn_clicked(_:)))
        //let leftButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: btn_clicked())
        //let rightButton = UIBarButtonItem(title: "Right", style: .plain, target: self, action: nil)
        var b = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(btn_clicked(_:)))
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = b
        //navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
    }
    
    func btn_clicked(_ sender: UIBarButtonItem) {
        performSegueWithIdentifier("chatToNewsFeed", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImageWithColor(UIColor.blueColor())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        self.count = 0
        self.itemRef = FIRDatabase.database().reference().child("chats").child("Erin") // 1

        let messageItem = [ // 2
            "text": text!,
            "senderID" : self.senderId,
            "senderName": "Me"
        ]
        self.itemRef!.childByAutoId().setValue(messageItem)
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        
        finishSendingMessage() // 5
    }
    
    private func observeMessages() {

        let ref = FIRDatabase.database().reference().child("chats").child("Erin")
        //let messageQuery = ref.queryLimited(toLast:25)
        let q = ref.queryLimitedToLast(25)
        let newMessageRefHandle = q.observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            let messageData = snapshot.value as! Dictionary<String, String>

            if let id = messageData["senderID"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String! where text.characters.count > 0 {
                self.addMessage(withId: id, name: name, text: text)
                
                // 5
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }

        })}
    
    
}
