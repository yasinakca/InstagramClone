//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by YASIN AKCA on 5.04.2020.
//  Copyright © 2020 YASIN AKCA. All rights reserved.
//

import UIKit
import Firebase
import  SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var emailArray = [String]()
    var commentArray = [String]()
    var likeArray = [Int]()
    var imageUrlArray = [String]()
    var documentIdArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
    }
    
    func getDataFromFirebase() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Error")
            }else {
                
                self.emailArray.removeAll(keepingCapacity: false)
                self.commentArray.removeAll(keepingCapacity: false)
                self.likeArray.removeAll(keepingCapacity: false)
                self.imageUrlArray.removeAll(keepingCapacity: false)
                self.documentIdArray.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents {
                    let documentId = document.documentID
                    self.documentIdArray.append(documentId)
                    
                    if let postedBy = document.get("postedBy") as? String {
                        self.emailArray.append(postedBy)
                    }
                    
                    if let comment = document.get("comment") as? String {
                        self.commentArray.append(comment)
                    }
                    
                    if let like = document.get("like") as? Int {
                        self.likeArray.append(like)
                    }
                    
                    if let imageUrl = document.get("imageUrl") as? String {
                        self.imageUrlArray.append(imageUrl)
                    }
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.pictureView.sd_setImage(with: URL(string: self.imageUrlArray[indexPath.row]))
        cell.userEmailLabel.text = emailArray[indexPath.row]
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell
    }
}
