//
//  FeedCell.swift
//  InstagramClone
//
//  Created by YASIN AKCA on 5.04.2020.
//  Copyright © 2020 YASIN AKCA. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeClicked(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeData = ["like" : likeCount + 1] as [String : Any]
            firestoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeData, merge: true)
            
        }
    }
}
