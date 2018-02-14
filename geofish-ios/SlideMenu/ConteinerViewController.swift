//
//  ConteinerViewController.swift
//  geofish-ios
//
//  Created by Ilyas on 08.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class ConteinerViewController: UIViewController {

    var delegate: ConteinerViewControllerDelegate?
    enum SlideOutState{
        case bothCollapsed
        case leftPanelExpanded
    }
    
    var centerNavigationController: UINavigationController!
    var curentViewController: UIViewController!
    var profileViewController: UserProfileVC!
    var newsViewController: NewsViewController!
    var mapViewController: MapViewController!
    var searchViewController: SearchViewController!
    
    var storyboardName: String!
    var viewName: String?
    
    var currentState: SlideOutState = .bothCollapsed{
        didSet {
            let shouldShadowShow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShadowShow)
        }
    }
    
    var leftViewController: SlidePanelViewController?
    
    let centerPanelExpandedOffset: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyboardName = "Map"
        switch storyboardName {
        case "Profile":
            profileViewController = UIStoryboard(name: "Profile", bundle: Bundle.main).instantiateInitialViewController() as! UserProfileVC
            profileViewController.delegate = self
            centerNavigationController = UINavigationController(rootViewController: profileViewController)
        case "News":
            newsViewController = UIStoryboard(name: "News", bundle: Bundle.main).instantiateInitialViewController() as! NewsViewController
            newsViewController.delegate = self
            centerNavigationController = UINavigationController(rootViewController: newsViewController)
        case "Map":
            mapViewController = UIStoryboard(name: "Map", bundle: Bundle.main).instantiateInitialViewController() as! MapViewController
            centerNavigationController = UINavigationController(rootViewController: mapViewController)
        case "Search":
            searchViewController = UIStoryboard(name: "Search", bundle: Bundle.main).instantiateInitialViewController() as! SearchViewController
            centerNavigationController = UINavigationController(rootViewController: searchViewController)
        default:
            break
        }
        
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)

    }
}

extension ConteinerViewController: UserProfileVCDelegate, NewsViewControllerDelegate, ConteinerViewControllerDelegate{
    func toggleLeftPanel(){
        let notAlredyExpanded = (currentState != .leftPanelExpanded)
        if notAlredyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlredyExpanded)
    }
    func collapseSlidePanel() {
        switch currentState {
        case .leftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    func addLeftPanelViewController(){
        guard leftViewController == nil else { return }
        
        if let vc = UIStoryboard.leftViewController(){
            vc.menuPoints = Menu.allMenuPoints()
            addChildSidePanelController(vc)
            leftViewController = vc
        }
    }
    func addChildSidePanelController(_ slidePanelController: SlidePanelViewController){
        slidePanelController.delegate = self
        view.insertSubview(slidePanelController.view, at: 0)
        
        addChildViewController(slidePanelController)
        slidePanelController.didMove(toParentViewController: self)
    }
    
    func animateLeftPanel(shouldExpand: Bool){ //проверяет было ли предложено свернуть или развернуть панель
        if shouldExpand{
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
        } else{
            animateCenterPanelXPosition(targetPosition: 0) {finished in
                self.currentState = .bothCollapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
    }
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    func showShadowForCenterViewController(_ shouldShowShadow: Bool){
        if shouldShowShadow{
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else{
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}

private extension UIStoryboard{
    static func slideMenu() -> UIStoryboard {
        return UIStoryboard(name: "SlideMenu", bundle: Bundle.main)
    }
    static func leftViewController() -> SlidePanelViewController? {
        return slideMenu().instantiateViewController(withIdentifier: "LeftViewController") as? SlidePanelViewController
    }
}

extension ConteinerViewController: UIGestureRecognizerDelegate {
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
        case .began:
            if currentState ==  .bothCollapsed{
                if gestureIsDraggingFromLeftToRight{
                    addLeftPanelViewController()
                }
            }
            showShadowForCenterViewController(true)
        case .changed:
            if let rview = recognizer.view{
                let shuldOpenLeft = (recognizer.translation(in: view).x > 0)
                if shuldOpenLeft {
                    rview.center.x = rview.center.x + recognizer.translation(in: view).x
                    recognizer.setTranslation(CGPoint.zero, in: view)
                }
            }
        case .ended:
            if let _ = leftViewController, let rview = recognizer.view{
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}

extension ConteinerViewController: SlidePanelViewControllerDelegate{
    func didSelectMenu(_ menu: Menu) {
        self.storyboardName = menu.storyboardName
        
//        profileViewController = UIStoryboard(name: "Profile", bundle: Bundle.main).instantiateInitialViewController() as! UserProfileVC
//        profileViewController.delegate = self
//        centerNavigationController = UINavigationController(rootViewController: profileViewController)
//        view.addSubview(centerNavigationController.view)
//        addChildViewController(centerNavigationController)
//
//        centerNavigationController.didMove(toParentViewController: self)
//
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        delegate?.collapseSlidePanel!()
    }
    
    
}
