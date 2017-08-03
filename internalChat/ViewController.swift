//
//  ViewController.swift
//  internalChat
//
//  Created by Jonathan Saldivar on 03/08/17.
//  Copyright © 2017 JonathanSaldivar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    func handleLogOut() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    
    }
    
    
}

