//
//  EditProfileViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/29/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImage: BoundCornerImage!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var codeNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.scrollView.bindToKeyboard()
        // set textField Delegate
        userNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        //
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonWasPressed(_ sender: Any) {
        // update and save to data to API in here
    }
    
    @IBAction func changeProfilePhotoButtonWasPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Notification", message: "Choose your photo from:", preferredStyle: UIAlertController.Style.alert)
        let btn_camera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (camera) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }else{
                print("Camera is not found")
            }
        }
        let btn_gallery = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) { (gallery) in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        alert.addAction(btn_camera)
        alert.addAction(btn_gallery)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func codeNumberWasPressed(_ sender: Any) {
    }
    
}
extension EditProfileViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //Do a few task in here: Update image for profileImage, send image to API
        //Update image for profileImage
        self.profileImage.image = image
        self.dismiss(animated: true, completion: nil)
    }
}
extension EditProfileViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField{
            emailTextField.becomeFirstResponder()
        }else if textField == emailTextField{
            phoneNumberTextField.becomeFirstResponder()
        }else{
            phoneNumberTextField.resignFirstResponder()
        }
        return true
    }
}
