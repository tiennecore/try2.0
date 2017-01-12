//
//  test2.swift
//  try2.0
//
//  Created by KPS on 12/01/2017.
//  Copyright © 2017 KPS. All rights reserved.
//

import UIKit




class test2: UIView {
	
	
	var l: CALayer {
		return test.layer
	}

	let image = UIImage(named: "cha.jpg")!
	l.contents = image.cgImage
	l.contentsGravity = kCAGravityResize
	l.masksToBounds = true
	l.cornerRadius=20
	l.borderWidth = 100.0
	l.shadowRadius = 10.0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
