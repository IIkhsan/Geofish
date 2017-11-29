//
//  WelcomeVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import VK_ios_sdk
import SVProgressHUD
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON

class WelcomeVC: UIViewController, VKSdkDelegate, VKSdkUIDelegate, UIAlertViewDelegate {
    
    var SCOPE: Array<Any>!
    let VK_APP_ID = "6251653"
    let SELECT_VIEWCONTROLLER = "LoginSeque"
    
    @IBOutlet weak var facebookButon: UIButton!
    @IBOutlet weak var vkButton: UIButton!
    
    var userData = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_PHOTOS, VK_PER_EMAIL]
        self.navigationController?.clearColor()
        self.navigationController?.setBackButton()
        VKSdk.initialize(withAppId: "6251653").register(self)
        VKSdk.instance().uiDelegate = self
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if (state == VKAuthorizationState.authorized){
                print("Переходим к старнице пользователя")
                self.vkButton.isEnabled = false
                self.vkGetUserData()
            }else if (error != nil) {
                UIAlertController.init(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert).show(self, sender: nil)
            }
        }
    }
    
    
    @IBAction func vkAutorizateButtonAction(_ sender: Any) {
        VKSdk.authorize(SCOPE)
    }
    
    @IBAction func okAutorizeButtonAction(_ sender: Any) {
        facebookLogin()
    }
    ///MARK: Facebook autharization
    func facebookLogin(){
        let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error == nil {
                let fbLoginResult: FBSDKLoginManagerLoginResult = result!
                if (result?.isCancelled)!{
                    return
                }
                if fbLoginResult.grantedPermissions.contains("email"){
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        
        if (FBSDKAccessToken.current() != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name,last_name,picture,birthday,id"]).start(completionHandler: { (connection, result, error) in
                if (error == nil) {
                    let json = JSON(result)
                    self.userData.firstName = json["first_name"].stringValue
                    self.userData.lastName = json["last_name"].stringValue
                    let bday = json["birthday"].stringValue.toDateFBBD()
                    self.userData.birthday = bday
//                    self.userData.photo = json["picture"]["data"]["url"].stringValue
                    let uid = json["id"].stringValue
                    self.userData.uid = Int(uid)
                    self.addInformationForUser()
                }else{
                    print("Error FB request")
                }
            })
        }
    }
    
    ///MARK: VK authorization
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.navigationController?.topViewController?.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: self.navigationController?.topViewController)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if ((result.token) != nil){
            print("Return acces token: ", result.token)
            vkGetUserData()
        }else if (result.error != nil){
            print(result.error)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("AUTHORIZATION FILED")
    }
    
    func vkGetUserData(){
        let request = VKApi.users().get([VK_API_FIELDS : "id,first_name,last_name,bdate,city,country,photo_max_orig,counters"])
            request?.setPreferredLang("ru")
            request?.execute(resultBlock: { (response) in
            let user: VKUser = (response?.parsedModel as! VKUsersArray).firstObject()
            self.userData.firstName = user.first_name
            self.userData.lastName = user.last_name
            self.userData.birthday = user.bdate.toDate()
//            self.userData.city = user.city.title
//            self.userData.photo = user.photo_max_orig
            self.userData.uid = user.id as? Int
            self.addInformationForUser()
        }) { (error) in
            print("Error return JSON")
        }
    }
    
    
    func alertMessage(){
        let alert = UIAlertController(title: "Внимание!", message: "Проверьте подключение к интернету и состояние сети", preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    ///MARK: Авторизация через соц сеть
    func signIN(){
        
    }
    ///MARK: Переход по странице заполнения оставшихся данных
    func addInformationForUser(){
        self.performSegue(withIdentifier: "socRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "socRegister"{
            let nameandPasswordVC = segue.destination as! NamePasswordVC
            nameandPasswordVC.user = self.userData
        }
    }
    
}
