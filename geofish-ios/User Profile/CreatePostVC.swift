//
//  CreatePostVC.swift
//  geofish-ios
//
//  Created by Ilyas on 31.12.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit

class CreatePostVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    @IBOutlet weak var locationLabelHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.setBackButton()
        postTextView.delegate = self

        postTextView.text = "Что нового?"
        postTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let userInfo = notification.userInfo{
            if let keyboardSize = ((userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
                bottomHeight.constant = keyboardSize.height
                view.setNeedsLayout()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        bottomHeight.constant = 0.0
        view.setNeedsLayout()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Что нового?"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func insertPhotoFromLibraryButtonAction(_ sender: Any) {
    }
    @IBAction func addPhotoFromCameraButtonAction(_ sender: Any) {
    }
    
    @IBAction func addLocationButtonAction(_ sender: Any) {
    }
    @IBAction func hideKeyboardButtonAction(_ sender: Any) {
        print("view end editing")
        view.endEditing(true)
    }
    
}
