//
//  WelcomeVC.swift
//  geofish-ios
//
//  Created by Ilyas on 23.10.17.
//  Copyright © 2017 Ilyas. All rights reserved.
//

import UIKit
import VK_ios_sdk

class WelcomeVC: UIViewController, VKSdkUIDelegate, VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.view.window?.rootViewController?.present(controller, animated: true)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearColor()
        self.navigationController?.setBackButton()
        let sdkInstance = VKSdk.initialize(withAppId: "6251653")
        sdkInstance?.register(self as VKSdkDelegate)
        sdkInstance?.uiDelegate.self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func vkAutorizateButtonAction(_ sender: Any) {
        let scope = ["friends", "email"]
        VKSdk.authorize(scope)
    }
    @IBAction func okAutorizeButtonAction(_ sender: Any) {
        
    }
    
}
