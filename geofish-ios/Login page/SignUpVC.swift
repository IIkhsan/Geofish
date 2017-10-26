//
//  SignUpVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

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
            user.email = self.emailTextField.text
            performSegue(withIdentifier: "showNamePassword", sender: nil)
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
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nameandPasswordVC = segue.destination as! NamePasswordVC
        nameandPasswordVC.user = self.user
     }
 

}
