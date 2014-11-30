//
//  UIViewControllerExtension.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 07/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit
extension UIViewController {
    
    public func toggleSideMenuView () {
        sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    public func hideSideMenuView () {
        sideMenuController()?.sideMenu?.hideSideMenu()
    }
    
    public func showSideMenuView () {
        sideMenuController()?.sideMenu?.showSideMenu()
    }
    public func enableSideMenu () {
        sideMenuController()?.sideMenu?.enableSideMenu()
    }
    public func disableSideMenu () {
        sideMenuController()?.sideMenu?.disableSideMenu()
        navigationItem.leftBarButtonItem = nil
    }
    internal func sideMenuController () -> SideMenuProtocol? {
        var iteration : UIViewController? = self.parentViewController
        if (iteration == nil) {
            return topMostController()
        }
        do {
            if (iteration is SideMenuProtocol) {
                return iteration as? SideMenuProtocol
            } else if (iteration?.parentViewController != nil && iteration?.parentViewController != iteration) {
                iteration = iteration!.parentViewController;
            } else {
                iteration = nil;
            }
        } while (iteration != nil)
        
        return iteration as? SideMenuProtocol
    }
    
    internal func topMostController () -> SideMenuProtocol? {
        var topController : UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController
        while (topController?.presentedViewController is SideMenuProtocol) {
            topController = topController?.presentedViewController;
        }
        
        return topController as? SideMenuProtocol
    }
    
    @IBAction func toogleSideMenu(sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
}