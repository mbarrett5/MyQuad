//
//  EditPlayViewController.swift
//  LearnFirebase
//
//  Created by Michael Barrett on 4/26/17.
//  Copyright © 2017 Michael Barrett. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class EditPlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(">>>>> EditPlayVC has appeared")
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            print("Signed in from EditPlayVC")
            let userEmail = (FIRAuth.auth()?.currentUser?.email)!
            let displayName = (FIRAuth.auth()?.currentUser?.displayName)!
            print("uuuuu userEmail = \(userEmail) and displayName = \(displayName)")
        } else {
            performSegue(withIdentifier: "ToLogin", sender: nil)
        }

    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "ToLogin", sender: nil)
    }


}
