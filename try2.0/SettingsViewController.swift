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
        
        let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )
        let user = FIRAuth.auth()?.currentUser
        let checklist = ref.child("users")
        let usermail = user?.email
        checklist.observeSingleEvent(of: .value, with: {(snap) in
            
        if let snapDict = snap.value as? [String:AnyObject]
            {
                    
            for each in snapDict{
                        
                let childValue = each.value["Email"]!
                let name  = each.value["Name"]!
                let score = each.value["Score"]!
                if childValue != nil
                    {
                    if (childValue as? String == usermail )
                        {
                            self.scoreLabel.text = "\(score!)"
                            self.nameLabel.text = name as! String?
                        }
                            
                    }
                        
                }
                    
                    
            }
        })

        
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
