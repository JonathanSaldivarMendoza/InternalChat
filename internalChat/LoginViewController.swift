 //
 //  LoginViewController.swift
 //  internalChat
 //
 //  Created by Jonathan Saldivar on 03/08/17.
 //  Copyright © 2017 JonathanSaldivar. All rights reserved.
 //
 
 import UIKit
 import Firebase
 import FirebaseAuth
 class LoginViewController: UIViewController {
    
    let imputsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var logiRregisterButtom: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleLoginRegister ), for: .touchUpInside)
        return button
    }()
    
    func handleLoginRegister(){
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0{
            handleLogin()
        } else {
            handleRegister()
        }
        
    }
    
    func handleLogin(){
        
        guard let email = emailtextField.text, let password = passwordtextField.text else {
            print("formulario no valido")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    
    }
    
    let nametextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailtextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordtextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var porfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PasswordImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        //imageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleSelectPorfileImageView)))
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPorfileImageView)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["login","register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleRegisterLoginChange), for: .valueChanged)
        return sc
    }()
    
    func handleRegisterLoginChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        logiRregisterButtom.setTitle(title, for: .normal)
        
        // change dimencion of containerimputs
        imputContainerViewHeigthAnchor.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 90: 150
        
        //change heightof nametextfield
        nametextFielHeightAnchor.isActive = false
        nametextFielHeightAnchor = nametextField.heightAnchor.constraint(equalTo: imputsContainer.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0: 1/3)
        nametextFielHeightAnchor.isActive = true
        
        //change heightof EmailTextfield
        emailTextFieldHeightAnchor.isActive = false
        emailTextFieldHeightAnchor = emailtextField.heightAnchor.constraint(equalTo: imputsContainer.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2: 1/3)
        emailTextFieldHeightAnchor.isActive = true
        
        //change heightof PasswordTextField
        passwordTextFieldHeightAnchor.isActive = false
        passwordTextFieldHeightAnchor = passwordtextField.heightAnchor.constraint(equalTo: imputsContainer.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2: 1/3)
        passwordTextFieldHeightAnchor.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(imputsContainer)
        view.addSubview(logiRregisterButtom)
        view.addSubview(porfileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        setupImputsContainerView()
        setupLoginRegisterButtom()
        setupImagePorfileView()
        setuploginRegisterSegmentedControl()
    }
    
    func setuploginRegisterSegmentedControl(){
        
        // need x, y, width, height constrains
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: imputsContainer.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: imputsContainer.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
    func setupImagePorfileView(){
        
        // need x, y, width, height constrains
        
        porfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        porfileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        porfileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        porfileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    var imputContainerViewHeigthAnchor = NSLayoutConstraint()
    var nametextFielHeightAnchor = NSLayoutConstraint()
    var emailTextFieldHeightAnchor = NSLayoutConstraint()
    var passwordTextFieldHeightAnchor = NSLayoutConstraint()
    
    func setupImputsContainerView(){
        
        // need x, y, width, height constrains
        
        imputsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imputsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imputsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        imputContainerViewHeigthAnchor = imputsContainer.heightAnchor.constraint(equalToConstant: 150)
            imputContainerViewHeigthAnchor.isActive = true
        
        imputsContainer.addSubview(nametextField)
        imputsContainer.addSubview(nameSeparatorView)
        imputsContainer.addSubview(emailtextField)
        imputsContainer.addSubview(emailSeparatorView)
        imputsContainer.addSubview(passwordtextField)
        
        // need x, y, width, height constrains
        
        nametextField.leftAnchor.constraint(equalTo: imputsContainer.leftAnchor, constant: 12).isActive = true
        nametextField.topAnchor.constraint(equalTo: imputsContainer.topAnchor).isActive = true
        nametextField.widthAnchor.constraint(equalTo: imputsContainer.widthAnchor).isActive = true
        nametextFielHeightAnchor = nametextField.heightAnchor.constraint(equalTo: imputsContainer.heightAnchor, multiplier: 1/3)
        nametextFielHeightAnchor.isActive = true
        
        // need x, y, width, height constrains SeparatorView
        nameSeparatorView.leftAnchor.constraint(equalTo: imputsContainer.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nametextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: imputsContainer.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // need x, y, width, height constrains
        
        emailtextField.leftAnchor.constraint(equalTo: imputsContainer.leftAnchor, constant: 12).isActive = true
        emailtextField.topAnchor.constraint(equalTo: nametextField.bottomAnchor).isActive = true
        emailtextField.widthAnchor.constraint(equalTo: imputsContainer.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailtextField.heightAnchor.constraint(equalTo: imputsContainer.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor.isActive = true
        
        // need x, y, width, height constrains SeparatorView
        emailSeparatorView.leftAnchor.constraint(equalTo: imputsContainer.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailtextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: imputsContainer.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // need x, y, width, height constrains
        
        passwordtextField.leftAnchor.constraint(equalTo: imputsContainer.leftAnchor, constant: 12).isActive = true
        passwordtextField.topAnchor.constraint(equalTo: emailtextField.bottomAnchor).isActive = true
        passwordtextField.widthAnchor.constraint(equalTo: imputsContainer.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordtextField.heightAnchor.constraint(equalTo: imputsContainer.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor.isActive = true
        
        
    }
    
    func setupLoginRegisterButtom(){
        
        // need x, y, width, height constrains
        
        logiRregisterButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logiRregisterButtom.topAnchor.constraint(equalTo: imputsContainer.bottomAnchor, constant: 12).isActive = true
        logiRregisterButtom.widthAnchor.constraint(equalTo: imputsContainer.widthAnchor).isActive = true
        logiRregisterButtom.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
