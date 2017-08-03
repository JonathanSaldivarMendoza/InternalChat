 //
//  LoginViewController.swift
//  internalChat
//
//  Created by Jonathan Saldivar on 03/08/17.
//  Copyright © 2017 JonathanSaldivar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        let imputsContainer = UIView()
        imputsContainer.backgroundColor = UIColor.white
        
        view.addSubview(imputsContainer)
        
        // need x, y, width, height contrains
        imputsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        imputsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        imputsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
 
 extension UIColor{
 
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
 }
