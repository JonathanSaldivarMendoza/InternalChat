//
//  NewMenssageTableViewController.swift
//  internalChat
//
//  Created by Jonathan Saldivar on 07/08/17.
//  Copyright © 2017 JonathanSaldivar. All rights reserved.
//

import UIKit
import Firebase

class NewMenssageTableViewController: UITableViewController {
    
    let cellId  = "cellId"
    var usersaApp = [UserApp]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        tableView.register(userCell.self, forCellReuseIdentifier: cellId)
        fetchUser()
    }
    
    func fetchUser(){
        
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictonary = snapshot.value as? [String: AnyObject] {
                let user = UserApp()
                user.setValuesForKeys(dictonary)
                self.usersaApp.append(user)
                
                self.tableView.reloadData()
                //print(user.name, user.email)
            }
        }, withCancel: nil)
    }
    
    func handleCancel() {
    dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersaApp.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! userCell
        let user = usersaApp[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
//        cell.imageView?.image = #imageLiteral(resourceName: "PasswordImage")
//        cell.imageView?.contentMode = .scaleAspectFit
        
        if let porfileImage = user.porfileImageURL {
            cell.porfileImageView.loadImagesUsingCacheWhitURLString(urlString: porfileImage
            )
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

class userCell: UITableViewCell {
    
    override func  layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2 , width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
        
    }
    
    var porfileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = 24
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(porfileImageView)
        
        // iOs 9 Constrains Anchors
        //need x, y, width, height
        porfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        porfileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        porfileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        porfileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


