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

class WelcomeVC: UIViewController, VKSdkDelegate, VKSdkUIDelegate, UIAlertViewDelegate {
    var SCOPE: Array<Any>!
    let VK_APP_ID = "6251653"
    let SELECT_VIEWCONTROLLER = "LoginSeque"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_PHOTOS, VK_PER_EMAIL]
        self.navigationController?.clearColor()
        self.navigationController?.setBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        vkInit()
    }
    
    func vkInit(){
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Загрузка...")
        VKSdk.initialize(withAppId: VK_APP_ID).register(self)
        VKSdk.instance().uiDelegate = self
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if state == VKAuthorizationState.authorized{ //если пользователь авторизован
                self.selectToRegisterOrAuthorizaton()
                //сессия с пользователем сохранена, нет необходимости заправшивать доступ
            }else if (error != nil) {
                self.alertMessage()
            }
        }
        SVProgressHUD.dismiss(withDelay: 0.5)
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
        VKSdk.authorize(SCOPE)
    }
    
    @IBAction func okAutorizeButtonAction(_ sender: Any) {
        
    }
    
    func alertMessage(){
        let alert = UIAlertController(title: "Внимание!", message: "Проверьте подключение к интернету и состояние сети", preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
