//
//  AddPhotoVC.swift
//  geofish-ios
//
//  Created by Ilyas on 24.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class AddPhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        
        imagePicker.delegate = self
    }
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImage.contentMode = .scaleAspectFit
            photoImage.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapAddImage(_ sender: Any) {
        //addPhotoButton.isEnabled = false
        
        let alertController : UIAlertController = UIAlertController(title: "Выберите", message: "Выберите камеру или галерею", preferredStyle: .actionSheet)
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
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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

    
    @IBAction func tapSkipButton(_ sender: Any) {
        
    }
    
}
