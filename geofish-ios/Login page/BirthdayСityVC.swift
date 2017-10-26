//
//  BirthdayCityVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class BirthdayCityVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var birthdayTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
    
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        self.addDatePicker()
        self.birthdayTextField.addTarget(self, action: #selector(textFieldDidCahnged(textField:)), for: .editingDidBegin)
        self.cityTextField.addTarget(self, action: #selector(textFieldDidCahnged(textField:)), for: .editingChanged)
        
    }
    
    func addDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.minimumDate = Date(dateString: "01-01-1900")
        datePicker.maximumDate = Date(dateString: "01-01-2015")
        datePicker.setDate(Date.distantPast, animated: true)
        datePicker.addTarget(self, action: #selector(updateTextField), for: .valueChanged)
        self.birthdayTextField.inputView = datePicker
    }
    
    @objc func updateTextField() {
        let picker = self.birthdayTextField.inputView as! UIDatePicker
        self.birthdayTextField.text = picker.date.toString(dateFormat: "dd-MM-yyyy")

    }
    
    @IBAction func tapNextButton(_ sender: Any) {
        if isValidDate(date: birthdayTextField.text!) {
            user.birthday = Date(dateString: birthdayTextField.text!)
            if (cityTextField.text != nil) && (cityTextField.text != ""){
                user.city = cityTextField.text
                performSegue(withIdentifier: "showAddPhotoVC", sender: nil)
            }else{
                cityTextField.errorMessage = "Введите ваш город"
                cityTextField.updateColors()
            }
        }else{
            birthdayTextField.errorMessage = "Введите корректную дату рождения"
            birthdayTextField.updateColors()
        }
    }
    
    @objc func textFieldDidCahnged(textField: SkyFloatingLabelTextField) {
        textField.errorMessage = nil
        textField.updateColors()
    }
    
    func isValidDate(date:String) -> Bool {
        let dateRegEx = "[0-9]{2,2}+\\-[0-9]{2,2}+\\-[0-9]{4,4}"
        
        let datePredicate = NSPredicate(format: "SELF MATCHES %@", dateRegEx)
        return datePredicate.evaluate(with:date)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addPhotoVC = segue.destination as! AddPhotoVC
        addPhotoVC.user = self.user
    }

}
