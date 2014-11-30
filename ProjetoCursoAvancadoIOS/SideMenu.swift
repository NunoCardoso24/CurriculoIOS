//
//  SideMenu.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 06/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

@objc protocol SideMenuDelegate {
    optional func sideMenuWillOpen()
    optional func sideMenuWillClose()
}

@objc protocol SideMenuProtocol {
    var sideMenu : SideMenu? { get }
    func setContentViewController(contentViewController: UIViewController)
}


class SideMenu : NSObject {
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : SideMenu? = nil
    }
    internal var menuOpenX : CGFloat = 0-50 //-50 so menu have some margin and don't show empty space on animation
    private var enableMenu: Bool = true
    internal var menuWidth : CGFloat = 270.0
    internal let sideMenuContainerView =  UIView()
    private var menuTableViewController : UITableViewController!
    internal let sourceView : UIView!
    private let staticMenuView : UIView! //view para adicionar gesture de abrir menu apenas na borda esquerda do ecra
    weak var delegate : SideMenuDelegate?
    internal var isMenuOpen : Bool = false {
        didSet { //desliga ou liga sombra se esconder ou mostrar o menu, respetivamente
            if(isMenuOpen){
                sideMenuContainerView.layer.shadowOpacity = 0.8;
                staticMenuView.hidden = true //esconde para não estar por cima do menu(mesmo invisivel bloqueia as gestures do menu)
            }
            else{
                sideMenuContainerView.layer.shadowOpacity = 0.0;
                staticMenuView.hidden = false
            }
            
        }
    }
    
    init(sourceView: UIView) {
        super.init()

        self.sourceView = sourceView
        self.staticMenuView = UIView()
        
        self.setupMenuView()

        
        sourceView.addSubview(staticMenuView)
        //sourceView.bringSubviewToFront(staticMenuView)

        
        // Add right swipe gesture recognizer
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleGesture:")
        rightSwipeGestureRecognizer.direction =  UISwipeGestureRecognizerDirection.Right
        staticMenuView.addGestureRecognizer(rightSwipeGestureRecognizer)
        
        // Add left swipe gesture recognizer
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleGesture:")
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        
        sideMenuContainerView.addGestureRecognizer(leftSwipeGestureRecognizer)
        
        dispatch_once(&Static.onceToken) {
            Static.instance = self
        }
        
    }
    
    convenience init(sourceView: UIView, menuTableViewController: UITableViewController) {
        self.init(sourceView: sourceView)
        self.menuTableViewController = menuTableViewController
        self.menuTableViewController.tableView.frame = sideMenuContainerView.bounds
        self.menuTableViewController.tableView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        sideMenuContainerView.addSubview(self.menuTableViewController.tableView)

    }
    
    func updateFrame() {
        let menuFrame = CGRectMake(
            isMenuOpen ? menuOpenX : -menuWidth-1.0,
            sourceView.frame.origin.y,
            menuWidth,
            sourceView.frame.size.height
        )
        
        sideMenuContainerView.frame = menuFrame
        self.staticMenuView.frame = sideMenuContainerView.bounds
        self.staticMenuView.frame.origin.x =  -menuWidth*0.9
        self.staticMenuView.backgroundColor = UIColor.clearColor()
    }
    
    private func setupMenuView() {
        
        // Configure side menu container
        updateFrame()
        
        sideMenuContainerView.backgroundColor = UIColor.clearColor()
        sideMenuContainerView.clipsToBounds = false
        sideMenuContainerView.layer.masksToBounds = false
        sideMenuContainerView.layer.shadowOffset = CGSizeMake(5.0, 0.0)
        sideMenuContainerView.layer.shadowRadius = 10.0
        sideMenuContainerView.layer.shadowOpacity = 0.0

        
        
        sourceView.addSubview(sideMenuContainerView)

        if (NSClassFromString("UIVisualEffectView") != nil) {
            // Add blur view
            var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
            visualEffectView.frame = sideMenuContainerView.bounds
            visualEffectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
            sideMenuContainerView.addSubview(visualEffectView)
        }

    }
    
    private func toggleMenu (shouldOpen: Bool) {
        isMenuOpen = shouldOpen
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.sideMenuContainerView.frame.origin.x = (shouldOpen) ? self.menuOpenX : -self.menuWidth
            }, completion: nil)
        
    }
    
    internal func handleGesture(gesture: UISwipeGestureRecognizer) {
        if(enableMenu){
            
            if (gesture.direction == .Left) {
                toggleMenu(false)
                delegate?.sideMenuWillClose?()
            }
            else{
                
                toggleMenu(true)
                delegate?.sideMenuWillOpen?()
            }
        }
    }
    
    internal func toggleMenu () {
        if (isMenuOpen) {
            toggleMenu(false)
        }
        else {
            toggleMenu(true)
        }
    }
    
    internal func showSideMenu () {
        if (!isMenuOpen) {
            toggleMenu(true)
        }
    }
    
    internal func hideSideMenu () {
        if (isMenuOpen) {
            toggleMenu(false)
        }
    }
    
    internal func disableSideMenu () {
        enableMenu = false
        hideSideMenu ()
    }
    internal func enableSideMenu () {
        enableMenu = true        
    }
    
    
}
