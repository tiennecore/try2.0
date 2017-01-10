//
//  SettingsViewController.swift
//  try2.0
//
//  Created by Claire Sagalow on 10/01/2017.
//  Copyright © 2017 KPS. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = FIRAuth.auth()?.currentUser
        let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )
        
        let userName = user?.displayName
        
        let test = ref.child("users").child(userName!)
        test.observeSingleEvent(of: .value, with: { snapshot in
            
            let snap = snapshot.value as! NSDictionary
            //problem NSCFnumber
            let score = snap.value(forKey: "Score")! as! String //change From here to score when score is implemented
            
            self.scoreLabel.text = score
            
        })

        
        self.nameLabel.text = (user?.displayName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
