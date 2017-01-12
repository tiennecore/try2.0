//
//  add_photo_ViewController.swift
//  try2.0
//
//  Created by KPS on 12/01/2017.
//  Copyright © 2017 KPS. All rights reserved.
//

import UIKit

class add_photo_ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	@IBOutlet weak var myImageView: UIImageView!
	
	@IBAction func import_image(_ sender: Any) {
			let image = UIImagePickerController()
			image.delegate = self
			
			image.sourceType = UIImagePickerControllerSourceType.photoLibrary
			
			image.allowsEditing = true
			
			self.present(image, animated: true)
			{
				//After it is complete
			}
		}
		
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
		{
			if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
			{
				myImageView.image = image
			}
			else
			{
				//Error message
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
