//
//  ViewController.swift
//  wodiki
//
//  Created by Douglas Brown on 9/4/18.
//  Copyright © 2018 dougbrownioio. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        
        // get the default Firebase Auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            // log the error
            return
        }
        
        // set ourselves as the delegate
        authUI?.delegate = self
        
        // get a reference to the auth UI view controller
        let authViewController = authUI!.authViewController()
        
        // show it
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // check if there was an error
        if error != nil {
            // log the error
            return;
        }
        
        // authDataResult?.user.uid
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}
