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

    
	@IBOutlet weak var myImageView: UIImageView!
	

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
        
        let image = UIImagePickerController()
        image.delegate = self
        let user = FIRAuth.auth()?.currentUser
        var number = 0
        var from = ""
        print("Flag1")
        let ref = FIRDatabase.database().reference(fromURL: "https://howold-b00bc.firebaseio.com/" )
        let checklist = ref.child("users")
        let usermail = user?.email
        checklist.observeSingleEvent(of: .value, with: {(snap) in
            
            if let snapDict = snap.value as? [String:AnyObject]
            {
                
                for each in snapDict{
                    
                    let childValue = each.value["Email"]!
                    let nbPhotos = each.value["Photos"]!
                    let userfrom = each.value["From"]

                    if childValue != nil
                    {
                        if (childValue as? String == usermail )
                        {
                            number = nbPhotos as! Int
                            from = userfrom as! String
                        }
                        
                    }
                    
                }
                
                
            }
        })
        let storageRef = FIRStorage.storage().reference().child("\(user!.uid)_\(number)")
        let uploadData = UIImagePNGRepresentation(myImageView.image!)
        
        storageRef.put(uploadData!, metadata: nil, completion: { (metadata, error) in
            if error != nil {
                print(error!)
                return
            }
            print(metadata!)
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
