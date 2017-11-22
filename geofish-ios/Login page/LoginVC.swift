//
//  LoginVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import VK_ios_sdk
import Alamofire
import SVProgressHUD
import Locksmith
import SkyFloatingLabelTextField

class LoginVC: UIViewController {
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        emailTextField.addTarget(self, action: #selector(textFieldClaerColor(textfield:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldClaerColor(textfield:)), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        emailTextField.text = emailTextField.text?.lowercased()
        if emailTextField.isValid(.email){
            if passwordTextField.isValid(.password){
                sendRequestForAuthorization()
            }else{
                passwordTextField.errorMessage = "Длинна пароля должна быть больше 6 символов"
                passwordTextField.updateColors()
            }
        }else{
            emailTextField.errorMessage = "Неверный формат email"
            emailTextField.updateColors()
        }
    }
    
    func sendRequestForAuthorization() {
        SVProgressHUD.show(withStatus: "Загрузка...")
        self.autorization(email: emailTextField.text!, password: passwordTextField.text!) { (token, id) in
            print(token, id)
            do{
                try Locksmith.deleteDataForUserAccount(userAccount: "Account")
                try Locksmith.saveData(data: ["token": token, "id": id], forUserAccount: "Account")
                print("Токен и ид сохранены")
            }catch{
            }
            print("Пользователь авторизован")
        }
    }
    
    @objc func textFieldClaerColor(textfield: SkyFloatingLabelTextField) {
        textfield.clearErrorColor()
    }
    
    func autorization(email: String, password: String, completion: @escaping(String, Int) -> Void){
        
        let values = ["email" : email, "password" : password] as Dictionary
        let header = ["Accept" : "application/json"]
        
        Alamofire.request("https://geofish.herokuapp.com/api/v1/login", method: .post, parameters: values, headers: header).responseJSON { (response) in
            print(response)
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("Запрос успешный")
                default:
                    print("Ошибка запроса: \(status)")
                    SVProgressHUD.showError(withStatus: "Неверный логин или пароль")
                }
            }
            //to get JSON return value
            if let data = response.result.value {
                let JSON = data as! NSDictionary
                if let error = JSON.object(forKey: "errors"){
                    print(error)
                }else{
                    let token = JSON.object(forKey: "token") as! String
                    let id = JSON.object(forKey: "id") as! Int
                    SVProgressHUD.showSuccess(withStatus: "Пользователь авторизован")
                    completion(token, id)
                }
            }else{
                SVProgressHUD.showError(withStatus: "Не правильное сочетание логин/пароль")
            }
        }
    }
}
