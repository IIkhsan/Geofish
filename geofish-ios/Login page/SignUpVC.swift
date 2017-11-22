//
//  SignUpVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import SVProgressHUD
import SkyFloatingLabelTextField
import Alamofire

class SignUpVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        emailTextField.autocapitalizationType = .none
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let _ = string.rangeOfCharacter(from: CharacterSet.uppercaseLetters){
            return false
        }
        return true
    }
    
    @IBAction func tapSignUpButton(_ sender: Any) {
        
        if  emailTextField.isValid(.email) {
            print("valid")
            SVProgressHUD.setDefaultMaskType(.clear)
            checkDuplicateEmail(email: self.emailTextField.text!, completion: { (result) in
                if result{
                    SVProgressHUD.showError(withStatus: "Такой email уже существует")
                    
                }else{
                    SVProgressHUD.showSuccess(withStatus: nil)
                    self.performSegue(withIdentifier: "showNamePassword", sender: nil)
                }
                SVProgressHUD.dismiss(withDelay: 1)
            })
        }else{
            emailTextField.errorMessage = "Неверный формат email"
            emailTextField.updateColors()
        }
    }
    
    
    @objc func textFieldDidChange(textField: SkyFloatingLabelTextField) {
        textField.clearErrorColor()
    }
    
    func checkDuplicateEmail(email: String, completion: @escaping (Bool) -> Void){
        let values = ["email" : "\(email)"]
        let header = ["content-type" : "application/json"]
        SVProgressHUD.show(withStatus: "Загрузка...")
        Alamofire.request("https://geofish.herokuapp.com/api/v1/users/already_exist", method: .get, parameters: values, headers: header).responseJSON { (response) in
            print(response)
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("Запрос успешный")
                default:
                    print("Ошибка запроса: \(status)")
                }
            }
            //to get JSON return value
            if let data = response.result.value {
                let JSON = data as! NSDictionary
                let exist = JSON.object(forKey: "exist") as! Bool
                self.user.email = self.emailTextField.text
                print("Exist: \(exist)")
                completion(exist)
            }
        }
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nameandPasswordVC = segue.destination as! NamePasswordVC
        nameandPasswordVC.user = self.user
     }
 

}
