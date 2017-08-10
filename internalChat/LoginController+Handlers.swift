//
//  LoginController+Handlers.swift
//  internalChat
//
//  Created by Jonathan Saldivar on 10/08/17.
//  Copyright © 2017 JonathanSaldivar. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func handleRegister(){
        print("auch")
        guard let email = emailtextField.text, let password = passwordtextField.text, let name = nametextField.text else {
            print("formulario no valido")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
            
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
            
            guard let uid = user?.uid else{
                return
            }
            
            
            let imageNameID = NSUUID().uuidString
            let storageReference = Storage.storage().reference().child("Porfile_images").child("\(imageNameID).png")
            
            if let uploadData = UIImagePNGRepresentation(self.porfileImageView.image!){
                storageReference.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        return
                    }
                    if let porfileImage = metadata?.downloadURL()?.absoluteString{
                        let values = [
                            "name": name,
                            "email": email,
                            "porfileImageURL": porfileImage
                        ]
                        self.registerUserIntoaDataBasewhitUID(uid: uid, values: values)
                    }
                })
            }
        }
    }
    
    func registerUserIntoaDataBasewhitUID(uid: String, values : [String: String]){
        let ref = Database.database().reference(fromURL: "https://internalchat-350dd.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil{
                print(err?.localizedDescription as Any)
                return
            }
            self.dismiss(animated: true, completion:  nil)
        })
    }
    
    func handleSelectPorfileImageView() {
        print(123)
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImagefromPicker: UIImage?
        
        if let editImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            selectedImagefromPicker = editImage
            
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImagefromPicker = originalImage
        }
        
        if let selectecImage = selectedImagefromPicker{
            porfileImageView.image = selectecImage
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cenceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}
