//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatViewController: UIViewController {
    let db = Firestore.firestore()
    
    
    var messages:[Message]=[
        Message(sender: "1@2.com", body: "hello"),
        Message(sender: "1@2.com", body: "how are you")
    ]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        navigationItem.hidesBackButton=true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
      
    }
    
    func loadMessages(){
        
        db.collection(K.FStore.collectionName).order(by:K.FStore.dateField).addSnapshotListener() { (querySnapshot, err) in
            self.messages=[]
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data=document.data()
                    self.messages.append(Message(sender: data[K.FStore.senderField] as! String, body: data[K.FStore.bodyField] as! String))

                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                        let indexPath = IndexPath(row:self.messages.count-1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }
        }
     
 
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField :messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField:Date().timeIntervalSince1970]
            ) { [self] error in
                if let  e  = error {print(e)}
                else {print("successfully saved data")}
                self.loadMessages()
                messageTextfield.text=""
               
            }
            
        }
        
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
    do {
      try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
      
        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier) as! MessageCell
        
        // set the text from the data model
        cell.label?.text = self.messages[indexPath.row].body
        
        //this is message from current user
        if  message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden=true
            cell.rightImageView.isHidden=false
            cell.messageBubble.backgroundColor=UIColor(named:K.BrandColors.lightPurple)
            cell.label.textColor=UIColor(named:K.BrandColors.purple)
            
        } else {
            cell.leftImageView.isHidden=false
            cell.rightImageView.isHidden=true
            cell.messageBubble.backgroundColor=UIColor(named:K.BrandColors.blue)
            cell.label.textColor=UIColor(named:K.BrandColors.lightBlue)
            
        }
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}

