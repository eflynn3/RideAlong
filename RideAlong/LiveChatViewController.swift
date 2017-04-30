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
        self.count = messages.count + 1
        self.itemRef = FIRDatabase.database().reference().child("chats").child("Erin").child(String(messages.count + 1)) // 1
        let messageItem = [ // 2
            "text": text!,
            "senderID" : self.senderId,
            "senderName": "Me"
            ]
        
        self.itemRef!.setValue(messageItem) // 3
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        
        finishSendingMessage() // 5
        observeMessages()
    }
    
    private func observeMessages() {
        //messageRef = self.userRef!.child("users").child(self.senderId!).child("chats").child(self.chatUser)
        // 1.
        
        let ref = FIRDatabase.database().reference().child("chats").child("Erin").child(String(messages.count + 1))
        print(messages.count + 1)
        //let messageQuery = ref.queryLimited(toLast:25)
        
        // 2. We can use the observe method to listen for new
        // messages being written to the Firebase DB
        //newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            // 3
          //  let messageData = snapshot.value as! Dictionary
        ref.observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? NSDictionary!{
                if let text = dict["text"] as! String! {
                    print("IN**********")
                    print(text)
                    let id = self.senderId
                    let name = "Erin"
                    self.addMessage(withId: id, name: name, text: text)
                    self.finishReceivingMessage()
                } else {
                    print("Error! Could not decode message data")
                }

            }})

    }

    
    
    /*override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //let cell = super.collectionView.dequeueReusableCellWithReuseIdentifier(reus, forIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        let cell = super.collectionView.dequeueReusableCellWithReuseIdentifier("reuseID", forIndexPath: indexPath) as! JSQMessagesCollectionView
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.whiteColor()
        } else {
            cell.textView?.textColor = UIColor.blackColor()
        }
        return cell
    }*/
    
}
