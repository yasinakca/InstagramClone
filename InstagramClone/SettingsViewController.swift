//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by YASIN AKCA on 5.04.2020.
//  Copyright © 2020 YASIN AKCA. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sigOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch {
            print("Error")
        }
    }
    
}
