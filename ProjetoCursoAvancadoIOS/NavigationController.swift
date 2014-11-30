//
//  NavigationController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 06/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//


import UIKit

class NavigationController: SideMenuNavigationController, SideMenuDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu = SideMenu(sourceView: self.view, menuTableViewController: MenuTableViewController())
        sideMenu?.delegate = self //optional
        
        //UIBarButtonItem.appearance().tintColor = UIColor.greenNice()
        //UINavigationBar.appearance().setBackgroundImage(UIImage(named: "textureNavigationBar.png"), forBarMetrics: UIBarMetrics.Default)
              // navigation bar showing over side menu
        view.bringSubviewToFront(navigationBar)
        
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    
    
      
    
}
