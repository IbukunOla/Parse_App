//
//  MessageCell.swift
//  Charse
//
//  Created by Ibukun on 3/7/18.
//  Copyright © 2018 Ibukun. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class MessageCell: UITableViewCell {


    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var adorableImageView: UIImageView!
    
    var message: PFObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
//        if let user = message["user"] {
//            let currectUser = user as? PFUser
//            usernameLabel.text = currectUser?.username
//            let adorableURL = URL(string: "http://api.adorable.io/avatar/15/test")
//            adorableImageView.af_setImage(withURL: adorableURL!)
//        } else {
//            usernameLabel.text = "Anonymous"
//        }
        //messageLabel.text = message["text"] as? String
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
