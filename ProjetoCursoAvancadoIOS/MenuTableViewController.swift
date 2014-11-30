//
//  MenuTableViewController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 06/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //desce 64 por causa da navigation bar
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //tableView.backgroundColor = UIColor(patternImage: UIImage(named: "textureNavigationBar.png")!).colorWithAlphaComponent(0.5)
        tableView.backgroundColor = UIColor.NavigationBarBackground()
        tableView.scrollsToTop = false        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return Menu().numberOfRows()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel.textColor = UIColor.NavigationBarTint()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
            cell!.selectedBackgroundView = selectedBackgroundView        }
    

        cell!.textLabel.text = "         \(Menu().getValue(indexPath.row))"
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        selectedMenuItem = indexPath.row
        
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        
        var stringVCDest = Menu().getIdentifier(selectedMenuItem)
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("\(stringVCDest)") as UIViewController
        
        sideMenuController()?.setContentViewController(destViewController)
    }
}