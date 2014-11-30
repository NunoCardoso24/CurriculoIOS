//
//  ViewController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 06/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

class AboutController: GlobalController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var lblNome: UILabel!
    private let NUMBER_OF_TITLES: Int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        navigationItem.title = NSLocalizedString("AboutMeTitle" , comment: aboutMe)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        enableSideMenu()
        
        updateTitlesBackground()
        foto.roundedView(5.0)
       /* for i in 1..<NUMBER_OF_TITLES
        {
            var valueView = self.view.viewWithTag(90+i)?
            valueView?.layer.position.x -= view.bounds.width
        }*/
    }
    override func viewDidAppear(animated: Bool)  {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        //if let dest = segue.destinationViewController as? ExperienciaProfissionalController{
          //  dest.transitioningDelegate = self
        //}
    }
    func updateTitlesBackground()
    {
        for i in 1..<NUMBER_OF_TITLES
        {
            var staticView = UIView()
            
            staticView.tag = i*10+i
            view.insertSubview(staticView, belowSubview: self.view.viewWithTag(i)!)

            var backView = self.view.viewWithTag(i*10+i)?
            var frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
            backView?.frame = frame
            backView?.center = self.view.viewWithTag(i)!.center
            backView?.frame.origin.x = 0
            backView?.backgroundColor = UIColor.NavigationBarTint()
        }

    }


    override func rotated(){
        super.rotated()
        updateTitlesBackground()
    }
}

