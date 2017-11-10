//
//  WelcomeVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import VK_ios_sdk

class WelcomeVC: UIViewController, VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.navigationController?.topViewController?.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if ((result) != nil){
            print(result.user.id)
        }else{
            print(result.error)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    let VK_APP_ID = "6251653"
    let SCOPE = ["email", "photos"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.navigationController?.setBackButton()
        let sdkInstance = VKSdk.initialize(withAppId: self.VK_APP_ID)
        sdkInstance?.register(self);
        sdkInstance?.uiDelegate = self;
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if state == VKAuthorizationState.authorized{
                
            }else{
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func vkAutorizateButtonAction(_ sender: Any) {
        
        VKSdk.authorize(SCOPE)
    }
    @IBAction func okAutorizeButtonAction(_ sender: Any) {
        
    }
    
}
