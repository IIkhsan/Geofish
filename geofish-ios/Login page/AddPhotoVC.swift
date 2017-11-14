//
//  AddPhotoVC.swift
//  geofish-ios
//
//  Created by Ilyas on 24.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import FirebaseStorage
import Alamofire

class AddPhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var replacePhotoButton: UIButton!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    var user: User!
    var addPhotoLabelText = "Добавить фотографию"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        self.addPhotoButton.addTarget(self, action: #selector(tapAddImage(_:)), for: .touchUpInside)
        self.addPhotoButton.setTitle(addPhotoLabelText, for: .normal)
        imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
    }
    
    @IBAction func tapSkipButton(_ sender: Any) {
        self.changeButtonFunctions()
        self.user.photo = ""
    }
    
    @IBAction func tapAddImage(_ sender: Any) {
        self.alertPhotoAndGalaryChoose()
    }
}
