//
//  ChatViewController.swift
//  Chat
//
//  Created by Adriancys Jesus Villegas Toro on 20/12/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        //        delete back button from navigation bar
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
//         to reuse the cell
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
  
//        update
        loadMessages()
        
    }
    
    func loadMessages(){
      
        
        //        getDocument() don't be good for read data to realtime for that reason i will use addSnapshotListener to get data to realtime
//        orderBy by the constant  date
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                
                print("We have a issue when we try to read the data \(e)")
            }else{
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument{
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String,
                           let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            
                            self.messages.append(newMessage)
                            
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                }
            }
        }
    }
}
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            //aqui asignamos el name de la db
            db.collection(K.FStore.collectionName).addDocument(data:
                                                                [K.FStore.senderField: messageSender,
                                                                 K.FStore.bodyField: messageBody,
      //                  timeIntervalSince1970 NOS DA LA CANTIDAD DE SEGUNDOS TRANSCURRIDOS DESDE 1 DE ENERO DE 1970
                                                                 K.FStore.dateField: Date().timeIntervalSince1970]
            ) { error in
                if let e = error {
                    print("There was a issue saving data to Firestore\(e)")
                }else {
                    print("Successfully")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            //        go to welcomeViewController
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        
    }
    
    
}
//MARK: - ChatViewControllerDelegate
extension ChatViewController: UITableViewDataSource{
    //    metodo para devolver la cantidad de mensajes y el contenido
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
//    esta se repite tantas veces como mensajes se tengan en la db
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.label.text = message.body
        
//          look who has write the message
//        this is a message for te current user
        if message.sender == Auth.auth().currentUser?.email{
            
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColor.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColor.purple)
            
        }
//        This message is from another sender
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColor.lightBlue)
            cell.label.textColor = UIColor(named: K.BrandColor.blue)
        }
        return cell
    }
    
    
}
