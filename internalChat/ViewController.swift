//
//  ViewController.swift
//  internalChat
//
//  Created by Jonathan Saldivar on 03/08/17.
//  Copyright © 2017 JonathanSaldivar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let ref = Database.database().reference(fromURL: "https://internalchat-350dd.firebaseio.com/")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "envelope"), style: .plain, target: self, action: #selector(handleNewMenssage))
        chekifUserisLoggedin()
        
    }
    
    func handleNewMenssage(){
        let mensajeController = NewMenssageTableViewController()
        let navcontroller = UINavigationController(rootViewController: mensajeController)
        present(navcontroller, animated: true, completion: nil)
    }
    
    func chekifUserisLoggedin() {
        
        let uid = Auth.auth().currentUser?.uid
        
        // User is not logged in
        if uid == nil{
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
        } else {
            
        }
    }
    
    func fetchUserAndNavBarTitle(){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                self.navigationItem.title = dictionary["name"] as? String
            }
            
        }, withCancel: nil)
    }
    
    
    func handleLogOut() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
        
        do {
            try Auth.auth().signOut()
        }catch let errorLogout {
            print(errorLogout)
        }
        
    }
    
    
}

