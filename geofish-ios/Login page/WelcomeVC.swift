//
//  WelcomeVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import VK_ios_sdk
import ok_ios_sdk
import SVProgressHUD

class WelcomeVC: UIViewController, VKSdkDelegate, VKSdkUIDelegate, UIAlertViewDelegate {
    var SCOPEVK: Array<Any>!
    var SCOPEOK: Array<Any>!
    let VK_APP_ID = "6251653"
    let SELECT_VIEWCONTROLLER = "LoginSeque"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SCOPEVK = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_PHOTOS, VK_PER_EMAIL]
        SCOPEOK = ["PHOTO_CONTENT", "APP_INVITE", "GET_EMAIL", "GET_EMAIL", "LONG_ACCESS_TOKEN"]
        self.navigationController?.clearColor()
        self.navigationController?.setBackButton()
    }
    
    func vkInit(){
        VKSdk.initialize(withAppId: VK_APP_ID).register(self)
        VKSdk.instance().uiDelegate = self
        VKSdk.wakeUpSession(SCOPEVK) { (state, error) in
            if state == VKAuthorizationState.authorized{
                //если пользователь авторизован
                self.selectToRegisterOrAuthorizaton()
                //сессия с пользователем сохранена, нет необходимости заправшивать доступ
            }else if (error != nil) {
                self.alertMessage()
            }
        }
    }
    
    func okInit() {
        OKSDK.authorize(withPermissions: SCOPEOK, success: { (data) in
            OKSDK.invokeMethod("users.getCurrentUser", arguments: nil, success: { (data) in
                print(data)
            }, error: { (error) in
                print(error)
            })
        }) { (error) in
            print(error)
        }
    }
    
    //Если пользователь уже авторизован в сессии то переход к странице
    func selectToRegisterOrAuthorizaton(){
        self.performSegue(withIdentifier: SELECT_VIEWCONTROLLER, sender: self)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.navigationController?.topViewController?.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: self.navigationController?.topViewController)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if (result.token != nil){
            self.selectToRegisterOrAuthorizaton()
        }else if (result.error != nil){
            UIAlertController.init(title: "Внимание!", message: "Ошибка авторизации", preferredStyle: .alert).show(self, sender: self)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        UIAlertController(title: nil, message: "Ошибка авторизации", preferredStyle: .alert).show(self, sender: self)
    }
    
    @IBAction func vkAutorizateButtonAction(_ sender: Any) {
        VKSdk.authorize(SCOPEVK)
    }
    
    @IBAction func okAutorizeButtonAction(_ sender: Any) {
        okInit()
    }
    
    func alertMessage(){
        let alert = UIAlertController(title: "Внимание!", message: "Проверьте подключение к интернету и состояние сети", preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
