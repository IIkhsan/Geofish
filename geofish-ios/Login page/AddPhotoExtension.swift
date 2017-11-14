//
//  AddPhotoExtension.swift
//  geofish-ios
//
//  Created by Ilyas on 29.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import Alamofire
import Locksmith

extension AddPhotoVC{
    @objc func complateRegistration(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Загрузка...")
        registerUserInTheDataBase(user: self.user) { (token, id) in
            print(token)
            print(id)
            do{
                try Locksmith.saveData(data: ["token": token, "id": id], forUserAccount: "Account")
            }catch{
                print("Данные не сохранены")
            }
        }
        print("Complate registr")
    }
    
    func registerUserInTheDataBase(user: User!, completion: @escaping(String, Int) -> Void){
        //        email, password, first_name, last_name, city, birthday, photo(optional)
        let values = ["email" : user.email, "password" : user.password, "first_name" : user.firstName, "last_name" : user.lastName, "city" : user.city, "birthday" : user.birthday, "photo" : user.photo] as Dictionary
        let header = ["Accept" : "application/json"]
        
        Alamofire.request("https://geofish.herokuapp.com/api/v1/signup", method: .post, parameters: values, headers: header).responseJSON { (response) in
            print(response)
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("Запрос успешный")
                default:
                    print("Ошибка запроса: \(status)")
                    SVProgressHUD.showError(withStatus: "Ошибка доступа")
                }
            }
            //to get JSON return value
            if let data = response.result.value {
                let JSON = data as! NSDictionary
                let token = JSON.object(forKey: "token") as! String
                let id = JSON.object(forKey: "id") as! Int
                SVProgressHUD.showSuccess(withStatus: "Профиль успешно создан")
                completion(token, id)
            }
        }
    }
    
    func photoUpload() {
        
        let imageName = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
        
        
        if let uploadData = UIImagePNGRepresentation(self.photoImage.image!){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error ?? "")
                    SVProgressHUD.showError(withStatus: "Ошибка загрузки фото")
                    return
                }
                
                if let profileImageURL = metadata?.downloadURL()?.absoluteString{
                    self.user.photo = profileImageURL
                    SVProgressHUD.showSuccess(withStatus: "Фотография загружена")
                    
                    if self.replacePhotoButton.isHidden{
                        self.changeButtonFunctions()
                        self.replacePhotoButton.isHidden = false
                        self.replacePhotoButton.addTarget(self, action: #selector(self.tapAddImage(_:)), for: .touchUpInside)
                    }
                    print(profileImageURL)
                }

            })
        }
        
        
        
    }
    
    func changeButtonFunctions(){
        self.skipButton.removeFromSuperview()
        //self.skipButton.isHidden = true
        self.addPhotoLabelText = "Закончить"
        self.addPhotoButton.setTitle(self.addPhotoLabelText, for: .normal)
        self.addPhotoButton.removeTarget(self, action: #selector(self.tapAddImage(_:)), for: .touchUpInside)
        self.addPhotoButton.addTarget(self, action: #selector(self.complateRegistration(_:)), for: .touchUpInside)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
            
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            photoImage.image = selectedImage
        }
        self.photoUpload()
        dismiss(animated: true, completion: nil)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func alertPhotoAndGalaryChoose() {
        let alertController : UIAlertController = UIAlertController(title: "Выберите источник изображения", message: nil, preferredStyle: .actionSheet)
        let cameraAction : UIAlertAction = UIAlertAction(title: "Камера", style: .default, handler: {(cameraAction) in
            print("camera Selected...")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == true {
                self.imagePicker.sourceType = .camera
                self.present()
                
            }else{
                self.present(self.showAlert(Title: "Ошибка", Message: "Камера недоступна на этом устройстве или не предаставлен доступ"), animated: true, completion: nil)
                
            }
            
        })
        
        let libraryAction : UIAlertAction = UIAlertAction(title: "Галерея", style: .default, handler: {(libraryAction) in
            
            print("Photo library selected....")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) == true {
                self.imagePicker.sourceType = .photoLibrary
                self.present()
                
            }else{
                
                self.present(self.showAlert(Title: "Ошибка", Message: "Галерея недоступна на этом устройстве или не предаставлен доступ"), animated: true, completion: nil)
            }
        })
        
        let cancelAction : UIAlertAction = UIAlertAction(title: "Отмена", style: .cancel , handler: {(cancelActn) in
            print("Cancel action was pressed")
        })
        
        alertController.addAction(cameraAction)
        
        alertController.addAction(libraryAction)
        
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func present(){
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("info of the pic reached :\(info) ")
        self.imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    //Show Alert
    
    func showAlert(Title : String!, Message : String!)  -> UIAlertController {
        
        let alertController : UIAlertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let okAction : UIAlertAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            print("User pressed ok function")
            
        }
        
        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        return alertController
    }
}
