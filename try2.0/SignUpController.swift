//
//  SignUpController.swift
//  try2.0
//
//  Created by Brian on 21/12/2016.
//  Copyright © 2016 KPS. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth

class SignUpController: UIViewController {
    
    
    @IBOutlet weak var usernameSignUp: UITextField!
    @IBOutlet weak var mailSignUp: UITextField!
    @IBOutlet weak var passwordSignUp: UITextField!

    
    var context:NSManagedObjectContext?
    
    @IBAction func SignUp(_ sender: Any) {
        let userName = usernameSignUp.text
        let userEmail = mailSignUp.text
        let userPassword = passwordSignUp.text
        
        if userEmail == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )
            ref.child("users").observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
            if snapshot.hasChild(userName!){
                
                let alertController = UIAlertController(title: "Error", message: "Username already used", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                    
                }
                else
                {
                    FIRAuth.auth()?.createUser(withEmail: self.mailSignUp.text!, password: self.passwordSignUp.text!) { (user, error) in
                    
                    
                        if error == nil {
                            
                            print("You have successfully signed up")
                            _ = ref.child("users").child(userName!).setValue(["Name" : userName!,  "Email":userEmail!, "Password" :userPassword!, "Score" : 0, "Photos" : 0, "From" : "Local"])
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier:"Game")
                            self.present(vc!, animated: true, completion: nil)
                        
                        } else {
                            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            })
            


            
            
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
