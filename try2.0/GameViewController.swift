//
//  ViewController.swift
//  try2.0
//
//  Created by KPS on 12/12/2016.
//  Copyright © 2016 KPS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorageUI
import SDWebImage

class GameViewController: UIViewController {
	@IBOutlet weak var photo: UIImageView!
    
	let reference: FIRStorageReference = FIRStorage.storage().reference(forURL: "gs://howold-b00bc.appspot.com/F8hPlGSIT5MZakJyCYuaXQjPZDr2_4")
	let placeholderImage = UIImage(named: "placeholder.jpg")
    
	@IBOutlet weak var value: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
        // Do any additional setup after loading the view, typically from a nib.
    }
	func setup() {
		photo.sd_setImage(with: reference, placeholderImage: placeholderImage)
        
        let user = FIRAuth.auth()?.currentUser
        
        let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )
        let checklist = ref.child("users")
        let usermail = user?.email
        checklist.observeSingleEvent(of: .value, with: {(snap) in
            
            if let snapDict = snap.value as? [String:AnyObject]
            {
                
                for each in snapDict{
                    
                    let childValue = each.value["Email"]!
                    let nbPhotos = each.value["Photos"]!
                    
                    
                    if childValue != nil
                    {
                        if (childValue as? String == usermail )
                        {
                            let number = nbPhotos as! Int
                            let storageRef = FIRStorage.storage().reference().child("\(user!.uid)_\(number)")
                            
                            storageRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                                if error != nil {
                                    // Uh-oh, an error occurred!
                                } else {
                                    // Data for "images/island.jpg" is returned
                                    print("test")
									
                                }
                            }

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

    @IBAction func slider(_ sender: UISlider) {
        value.text = String(Int(sender.value))
    }




}
