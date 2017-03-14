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
	@IBOutlet weak var photo2: UIStackView!
    
    @IBOutlet weak var slider: UISlider!
    
	var fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");
    
	let user = FIRAuth.auth()?.currentUser
    let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )

    
	@IBAction func gameslide(_ sender: UISlider) {
		values.text = String(Int(sender.value))
	}
	
	
    

	
	@IBOutlet weak var values: UILabel!
	@IBOutlet weak var negativevalue: UILabel!
	@IBOutlet weak var positivevalue: UILabel!
	
	let toImage = UIImage(named: "cha.jpg")!
	
  
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
        // Do any additional setup after loading the view, typically from a nib.
    }
	func setup() {
		
		
        
        
        let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )
        let checklist = ref.child("images")
        let uid = user?.uid
		var tab: [String] = []

        checklist.observeSingleEvent(of: .value, with: {(snap) in
			
            if let snapDict = snap.value as? [String:AnyObject]
            {
                for each in snapDict
				{
					if each.key != uid
					{
						tab.append(each.key)
						
					}
                    
                }
                
                
            }
			let randomNumber = Int(arc4random_uniform(UInt32(tab.count)))
			let random = tab[randomNumber]
			let checklist2 = ref.child("images").child(random)
			var tab2: [String] = []
            var ageTab : [Int] = []
			checklist2.observeSingleEvent(of: .value, with: {(snappy) in
				
				if let snapDico = snappy.value as? [String:AnyObject]
				{
					for same in snapDico{
						
						tab2.append(same.key)
                        ageTab.append(same.value["Age"]! as! Int)
					}
					
					
				}
				
				let randomNumber2 = Int(arc4random_uniform(UInt32(tab2.count)))
				let random2 = tab2[randomNumber2]
				let reference: FIRStorageReference = FIRStorage.storage().reference(forURL: "gs://howold-b00bc.appspot.com/\(random2)")
				print(random2)
				let placeholderImage = UIImage(named: "placeholder.jpg")
				
				
				self.photo.sd_setImage(with: reference, placeholderImage: placeholderImage)
				self.photo.layer.backgroundColor = UIColor.white.cgColor
				self.photo.layer.cornerRadius=20
				self.photo.layer.shadowOpacity = 0.7
				self.photo.layer.shadowRadius = 5
				self.photo.layer.borderColor = UIColor.black.cgColor
				self.photo.layer.borderWidth = 1
				self.photo.layer.contentsGravity = kCAGravityResizeAspect
				self.photo.layer.contentsScale = UIScreen.main.scale
				
				self.fadeAnim.fromValue = placeholderImage
				self.fadeAnim.toValue   = self.toImage
				self.fadeAnim.duration  = 1.5         //smoothest value
				
			
			
			})

		
		})
	}
	
    func score (_ age : Int)
    {
        
        let guessAge = Int(slider.value)
        let realAge  = age
        if (guessAge == realAge)
        {
            let checklist = self.ref.child("users")
            
            let usermail = self.user?.email
            checklist.observeSingleEvent(of: .value, with: {(snap) in
                
                if let snapDict = snap.value as? [String:AnyObject]
                {
                    
                    for each in snapDict{
                        
                        let childValue = each.value["Email"]!
                        var oldScore = each.value["Score"]! as! Int
                        let from = each.value["From"]! as! String
                        let name = each.value["Name"]!
                        if childValue != nil
                        {
                            if (childValue as? String == usermail )
                            {
                                
                                oldScore+=100
                                if from == "Google"
                                {
                                    let check = self.user?.uid
                                    let update = checklist.child("g_\(name!)_\(check!)")
                                    update.updateChildValues(["Score":oldScore])
                                }
                                else if from == "Facebook"
                                {
                                    let check = self.user?.uid
                                    let update = checklist.child("f_\(name!)_\(check!)")
                                    update.updateChildValues(["Score":oldScore])
                                }
                                else if from == "Local"
                                {
                                    let check = self.user?.uid
                                    let update = checklist.child("\(check!)")
                                    update.updateChildValues(["Score":oldScore])
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
            })
            
            
            print("Parfait")
        }
    }
	
	@IBAction func valider(_ sender: Any) {
		
		let realval = 0 as Int	
		
		if( realval != Int(values.text!)){
			
		}
		
		photo.layer.add(fadeAnim, forKey: "contents")
		
		photo.image = toImage
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }






}
