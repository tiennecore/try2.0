//
//  add_photo_ViewController.swift
//  try2.0
//
//  Created by KPS on 12/01/2017.
//  Copyright © 2017 KPS. All rights reserved.
//

import UIKit
import Firebase

class add_photo_ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let user = FIRAuth.auth()?.currentUser
    let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )
	@IBOutlet weak var myImageView: UIImageView!
	@IBOutlet weak var age: UITextField!
	

	@IBAction func import_image(_ sender: Any) {
            let image = UIImagePickerController()
			image.delegate = self
			
			image.sourceType = UIImagePickerControllerSourceType.photoLibrary
			
			image.allowsEditing = true
			
			self.present(image, animated: true)
			{
				
			}
		}

    
    @IBAction func Store(_ sender: Any) {
        
        
        let checklist = ref.child("users")

        let usermail = user?.email
        checklist.observeSingleEvent(of: .value, with: {(snap) in
            
            if let snapDict = snap.value as? [String:AnyObject]
            {
                
                for each in snapDict{
					
                    let childValue = each.value["Email"]!
                    let nbPhotos = each.value["Photos"]!
                    let from = each.value["From"]! as! String
                    let name = each.value["Name"]!

                    if childValue != nil
                    {
                        if (childValue as? String == usermail )
                        {
							
                            var num = nbPhotos as! Int
							let metaData = FIRStorageMetadata()
							metaData.contentType = "image/jpg"
							
							let storageRef = FIRStorage.storage().reference().child("\(self.user!.uid)_\(num)")
                            let uploadData = UIImagePNGRepresentation(self.myImageView.image!)
                            
                            storageRef.put(uploadData!, metadata: metaData, completion: { (metadata, error) in
                                if error != nil {
                                    print(error!)
                                    return
                                }
                                num = num + 1
                                print(metadata!)
                                
                                if from == "Google"
                                {
                                    let check = self.user?.uid
                                    let update = checklist.child("g_\(name!)_\(check!)")
                                    update.updateChildValues(["Photos":num])
                                }
                                else if from == "Facebook"
                                {
                                    let check = self.user?.uid
                                    let update = checklist.child("f_\(name!)_\(check!)")
                                    update.updateChildValues(["Photos":num])
                                }
                                else if from == "Local"
                                {
                                    let check = self.user?.uid
                                    let update = checklist.child("\(check!)")
                                    update.updateChildValues(["Photos":num])
                                }
                                let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )
								let addAge = Int(self.age.text!)
                                ref.child("images").child("\(self.user!.uid)/\(self.user!.uid)_\(num)").setValue(["Age" : addAge])
                            })
							num = num + 1
                        }
						
                    }
                    
                }
				
            }
            
        })

        
    }
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
		{
			if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
			{
				myImageView.image = originalImage
			}
            else if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
			{
				myImageView.image = editedImage
			}
			
			self.dismiss(animated: true, completion: nil)
            
		}
		
		
		override func viewDidLoad() {
			super.viewDidLoad()
			// Do any additional setup after loading the view, typically from a nib.
		}
		
		override func didReceiveMemoryWarning() {
			super.didReceiveMemoryWarning()
			// Dispose of any resources that can be recreated.
		}

}
