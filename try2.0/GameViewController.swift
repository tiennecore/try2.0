//
//  ViewController.swift
//  try2.0
//
//  Created by KPS on 12/12/2016.
//  Copyright © 2016 KPS. All rights reserved.
//

import UIKit
import Firebase

class GameViewController: UIViewController {
    

    
	@IBOutlet weak var value: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
        // Do any additional setup after loading the view, typically from a nib.
    }
	func setup() {
		let redLayer = CALayer()
        
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
                                    let image = UIImage(data: data!)
                                    redLayer.frame = CGRect(x: 120, y: 180, width: 180, height: 210)
                                    redLayer.backgroundColor = UIColor.white.cgColor
                                    redLayer.contents = image?.cgImage
                                    
                                    redLayer.cornerRadius=20
                                    redLayer.shadowOpacity = 0.7
                                    redLayer.shadowRadius = 5
                                    redLayer.borderColor = UIColor.gray.cgColor
                                    redLayer.borderWidth = 2
                                    
                                    redLayer.contentsGravity = kCAGravityResizeAspect
                                    redLayer.contentsScale = UIScreen.main.scale
                                    self.view.layer.addSublayer(redLayer)
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
