//
//  ProfilController.swift
//  try2.0
//
//  Created by Brian on 21/12/2016.
//  Copyright © 2016 KPS. All rights reserved.
//

import UIKit
import CoreData

class ProfilController: UIViewController {
    
    
    var context:NSManagedObjectContext?
    var profils : [NSDictionary]?
    

    
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchProfils(_predicate: ""){ (array, arrayData) in
            profils = array as? [NSDictionary]
        }
    }
    

    
    // MARK: - CoreData

     func fetchProfils(_predicate:String, completion : (_ array:NSArray,_ arrayData:NSArray)-> ())
     {
     var arr = [NSDictionary]()
     var arrData = [NSManagedObject]()
     let requete:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Profil")
     
     do
     {
     let users = try context!.fetch(requete)
     for user in users
     {
     let name = (user as AnyObject).value(forKey: "name")
     let password = (user as AnyObject).value(forKey: "password")
     let mail = (user as AnyObject).value(forKey: "mail")
     let score = (user as AnyObject).value(forKey: "score")
     
     let profilDict = ["name": name, "password": password, "mail": mail, "score": score]
     arr.append(profilDict as NSDictionary)
     arrData.append(user as! NSManagedObject)
     }
     
     completion(arr as NSArray, arrData as NSArray)
     
     }catch
     {
     print("erreur")
     }
     }


}
