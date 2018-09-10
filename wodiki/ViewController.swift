//
//  ViewController.swift
//  wodiki
//
//  Created by Douglas Brown on 9/4/18.
//  Copyright © 2018 dougbrownioio. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    var refMovements: DatabaseReference!
    
    @IBOutlet weak var AddMovementTextField: UITextField!
    @IBOutlet weak var tableMovements: UITableView!
    
    @IBAction func buttonAddMovement(_ sender: UIButton) {
        addMovement()
    }
    
    func addMovement() {
        let key = refMovements.childByAutoId().key
        let userId = Auth.auth().currentUser!.uid
        print(userId)
        let movement = [
            "id": key,
            "name": AddMovementTextField.text! as String
        ];
        
        refMovements.child(key).child(userId).setValue(movement)
        
        print("Movement Added")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refMovements = Database.database().reference().child("movements")
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
