//
//  ViewController.swift
//  try2.0
//
//  Created by KPS on 12/12/2016.
//  Copyright © 2016 KPS. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

	@IBOutlet weak var valeur: UILabel!
        
	override func viewDidLoad() {
		super.viewDidLoad()
        		// Do any additional setup after loading the view, typically from a nib.
	}
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	@IBAction func slider(_ sender: UISlider) {
		valeur.text = String(Int(sender.value))
	}
	


}

