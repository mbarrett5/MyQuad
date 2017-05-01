//
//  SignInViewController.swift
//  LearnFirebase
//
//  Created by Michael Barrett on 4/26/17.
//  Copyright © 2017 Michael Barrett. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }


}
