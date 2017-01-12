//
//  ViewController.swift
//  try2.0
//
//  Created by KPS on 12/12/2016.
//  Copyright © 2016 KPS. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: UIViewController {
    

    
	@IBOutlet weak var value: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
        // Do any additional setup after loading the view, typically from a nib.
    }
	func setup() {
		let redLayer = CALayer()
		let image = UIImage(named: "cha.jpg")!
		
		redLayer.frame = CGRect(x: 120, y: 180, width: 180, height: 210)
		redLayer.backgroundColor = UIColor.white.cgColor
		redLayer.contents = image.cgImage
		
		redLayer.cornerRadius=20
		redLayer.shadowOpacity = 0.7
		redLayer.shadowRadius = 5
		redLayer.borderColor = UIColor.gray.cgColor
		redLayer.borderWidth = 2
		
		redLayer.contentsGravity = kCAGravityResizeAspect
		redLayer.contentsScale = UIScreen.main.scale
		self.view.layer.addSublayer(redLayer)
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slider(_ sender: UISlider) {
        value.text = String(Int(sender.value))
    }
    

    
    
}
