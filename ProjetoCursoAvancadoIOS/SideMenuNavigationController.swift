//
//  SideMenuNavigationController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 06/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

class SideMenuNavigationController: UINavigationController, SideMenuProtocol{
    
    internal var sideMenu : SideMenu?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    init( menuTableViewController: UITableViewController, contentViewController: UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        
        if (contentViewController != nil) {
            self.viewControllers = [contentViewController!]
        }
        
        sideMenu = SideMenu(sourceView: self.view, menuTableViewController: menuTableViewController)
        
        view.bringSubviewToFront(navigationBar)
        
       
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    func setContentViewController(contentViewController: UIViewController) {
        self.sideMenu?.toggleMenu()
        
        //contentViewController.navigationItem.hidesBackButton = true
        
            self.setViewControllers([contentViewController], animated: true)
    }
    
    
    

    
    
}
