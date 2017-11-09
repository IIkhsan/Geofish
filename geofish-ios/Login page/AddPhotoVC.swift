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
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
    }
    
    func registerUserInTheDataBase(user: User!){
//        email, password, first_name, last_name, city, birthday, photo(optional)
        let values = ["email": user.email, "password": user.password, "first_name": user.firstName, "last_name": user.lastName, "city": user.city, "birthday": user.birthday, "photo": "photo"] as Dictionary
        
        
        Alamofire.request("https://geofish.herokuapp.com/api/v1/signup", method: .post, parameters: values).responseJSON { (response) in
            print(response)
        }
        
//        Alamofire.request(url, method: .post, parameters: values, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
//            switch response.result{
//            case .success(let JSON):
//                print("response :-----> ",response)
//            case .failure(let error):
//                print("Request failed with error: \(error)")
//                
//            }
//        }
    }
    
    
    @IBAction func tapSkipButton(_ sender: Any) {
        self.registerUserInTheDataBase(user: user)
    }
    
}
