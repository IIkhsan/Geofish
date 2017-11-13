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

class SignUpVC: UIViewController {
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func tapSignUpButton(_ sender: Any) {
        
        if  isValidEmail(testStr: emailTextField.text!) {
            print("valid")
            SVProgressHUD.setDefaultMaskType(.clear)
            checkDuplicateEmail(email: self.emailTextField.text!, completion: { (result) in
                if result{
                    SVProgressHUD.showError(withStatus: "Такой email уже существует")
                }else{
                    SVProgressHUD.showSuccess(withStatus: nil)
                    self.performSegue(withIdentifier: "showNamePassword", sender: nil)
                }
                SVProgressHUD.dismiss(withDelay: 0.3)
            })
        }else{
            emailTextField.errorMessage = "Неверный формат email"
            emailTextField.updateColors()
        }
    }
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        self.emailTextField.errorMessage = nil
        self.emailTextField.updateColors()
    }
    
    //    MARK: Email validator
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with:testStr)
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
