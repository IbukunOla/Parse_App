//
//  ChatViewController.swift
//  Charse
//
//  Created by Ibukun on 3/7/18.
//  Copyright © 2018 Ibukun. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [AnyObject] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("Message was saved!!")
                self.messageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        tableView.reloadData()
    }
    
    @objc func onTimer() {
        let query = PFQuery(className: "Message")
        //query.addDescendingOrder("createdAt")
        //query.includeKey("user")
        
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                print("Got Messages")
                if let messages = messages {
                    self.messages = messages
                    self.tableView.reloadData()
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let message = messages[indexPath.row] as! PFObject
        print(message)
        
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        }
        else {
            cell.usernameLabel.text = "test"
        }
        cell.messageLabel.text = message["text"] as? String
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
