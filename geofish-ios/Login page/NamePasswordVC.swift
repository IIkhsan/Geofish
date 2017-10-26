//
//  NamePasswordVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class NamePasswordVC: UIViewController {
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField! // <6 symbols
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        
        self.firstNameTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.lastNameTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNextButton(_ sender: Any) {
        if (firstNameTextField.text != nil) && (firstNameTextField.text != "") {
            user.firstName = firstNameTextField.text
            if (lastNameTextField.text != nil) && (lastNameTextField.text != "") {
                user.lastName = lastNameTextField.text
                if isValidPassword(password: passwordTextField.text!){
                    user.password = passwordTextField.text
                    performSegue(withIdentifier: "showDBandCity", sender: nil)
                }else{
                    passwordTextField.errorMessage = "Длинна пароля должна быть больше 6 символов"
                    passwordTextField.updateColors()
                }
            }else{
                lastNameTextField.errorMessage = "Поле не должно быть пустым"
                lastNameTextField.updateColors()
            }
        }else{
            firstNameTextField.errorMessage = "Поле не должно быть пустым"
            firstNameTextField.updateColors()
        }
    }
//    showDBandCity
    
    @objc func textFieldDidChange(textField: SkyFloatingLabelTextField) {
        textField.errorMessage = nil
        textField.updateColors()
    }
    
    
    func isValidPassword(password:String) -> Bool {
        let passwordRegEx = "[A-Z0-9a-z._%+-]{6,}"
        
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with:password)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let birthdayandCityVC = segue.destination as! BirthdayCityVC
        birthdayandCityVC.user = self.user
    }

}
