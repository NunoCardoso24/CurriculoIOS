//
//  LaunchController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 20/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

class LaunchController:UIViewController, UINavigationControllerDelegate{
    @IBOutlet weak var middleIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTap")))
        
        self.navigationController!.setNavigationBarHidden(true, animated: true)
        disableSideMenu()
    }

    override func viewDidAppear(animated: Bool)  {
        super.viewDidAppear(animated)
        middleIcon.roundedView(5.0)
        middleIcon.Animation(pulseAnimationDuration: 0.9)
    }
    func didTap() {
        self.performSegueWithIdentifier("proximo", sender: self)
    }

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        TransitionsManager.current.action = .DissmissLaunch
        return TransitionsManager.current
    }

}

