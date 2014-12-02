//
//  GlobalController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 08/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

class GlobalController:UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate{
     var menuButton: MenuButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nav = self.navigationController {
            self.navigationController!.delegate = self
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)

        menuButton = MenuButton()
        menuButton.sourceView=self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        self.view.backgroundColor = UIColor.ViewBackground()
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        TransitionsManager.current.action = .Present
        return TransitionsManager.current
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        TransitionsManager.current.action = .Dissmiss
        return TransitionsManager.current
    }
    
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        if (operation == .Push) {
            TransitionsManager.current.action = .Present
        }
        else {
            TransitionsManager.current.action = .Dissmiss
        }
        return TransitionsManager.current
    }
    //hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    func rotated(){
        SideMenu.Static.instance?.updateFrame()
    }  
}
