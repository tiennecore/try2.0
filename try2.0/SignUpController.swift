//
//  SignUpController.swift
//  try2.0
//
//  Created by Brian on 21/12/2016.
//  Copyright © 2016 KPS. All rights reserved.
//

import UIKit
import CoreData

class SignUpController: UIViewController {
    
    
    @IBOutlet weak var usernameSignUp: UITextField!
    @IBOutlet weak var mailSignUp: UITextField!
    @IBOutlet weak var passwordSignUp: UITextField!
    
    var context:NSManagedObjectContext?
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        profilCreation(name: usernameSignUp!.text!, password: passwordSignUp!.text!, mail: mailSignUp!.text!)
    }
    
    func profilCreation(name:String, password:String, mail:String)
    {
        let newProfil = NSEntityDescription.insertNewObject(forEntityName: "Profil", into: context! )
        
        newProfil.setValue(name, forKey: "name")
        newProfil.setValue(password, forKey: "password")
        newProfil.setValue(mail, forKey: "mail")
        newProfil.setValue(0, forKey: "score")
        
        do
        {
            try context?.save()
            print("Création avec succès")
            
        }catch{
            print("Création échouée")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
