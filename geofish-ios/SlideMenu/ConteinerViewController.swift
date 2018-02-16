//
//  ConteinerViewController.swift
//  geofish-ios
//
//  Created by Ilyas on 08.02.18.
//  Copyright © 2018 Ilyas. All rights reserved.
//

import UIKit

class ConteinerViewController: UIViewController {
    
    //MARK: - Enum'ы
    enum SlideOutState{
        case bothCollapsed
        case leftPanelExpanded
    }
    
    //MARK: - Переменные
    let centerPanelExpandedOffset           : CGFloat = 161
    
    var delegate                            : ConteinerViewControllerDelegate?
    var currentSideBarItem                  : SideBarItems = .map
    
    weak var leftViewController             : SlidePanelViewController?
    weak var centerNavigationController     : UINavigationController!
    
    lazy var storyboardFactory              : StoryboardFactory = StoryboardFactoryImplementation()
    
    var currentState: SlideOutState = .bothCollapsed{
        didSet {
            let shouldShadowShow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShadowShow)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        
    }
    
    func prepareView() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        UIApplication.shared.statusBarStyle = .lightContent
        centerNavigationController = UINavigationController(rootViewController: storyboardFactory.getStoryboard(with: currentSideBarItem.appStoryboard).instantiateInitialViewController() ?? UIViewController())
        
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMove(toParentViewController: self)
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
}

extension ConteinerViewController: ConteinerViewControllerDelegate{
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSlidePanel() {

        switch currentState {
            case .leftPanelExpanded:
                toggleLeftPanel()
            default:
                break
        }
        
    }
    
    func addChildSidePanelController(_ sidePanelController: SlidePanelViewController) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func addLeftPanelViewController() {
        guard leftViewController == nil else { return }
        
        if let vc = storyboardFactory.getStoryboard(with: .slideMenu).instantiateInitialViewController() as? SlidePanelViewController {
            leftViewController = vc
            addChildSidePanelController(vc)
        }
        
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(
                targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { [weak self] finished in
                guard let `self` = self else { return }
                self.currentState = .bothCollapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: { [weak self] in
                        guard let `self` = self else { return }
                        self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
}

extension ConteinerViewController: UIGestureRecognizerDelegate {
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
            
        case .began:
            if currentState == .bothCollapsed {
                if gestureIsDraggingFromLeftToRight {
                    addLeftPanelViewController()
                    showShadowForCenterViewController(true)
                }
            }
            
        case .changed:
            if self.centerNavigationController.view.frame.origin.x >= 0 || gestureIsDraggingFromLeftToRight {
                if let rview = recognizer.view {
                    rview.center.x = rview.center.x + recognizer.translation(in: view).x
                    recognizer.setTranslation(CGPoint.zero, in: view)
                }
            }
            
        case .ended:
            if let rview = recognizer.view {
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
    
}

extension ConteinerViewController: SlidePanelViewControllerDelegate {
    
    func didSelectMenu(_ menu: Menu) {
//        self.storyboardName = menu.storyboardName
        delegate?.collapseSlidePanel()
    }
    
}
