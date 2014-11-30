//
//  TraitOverrideViewController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 26/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit
class TraitOverrideViewController: UIViewController {
    
    /** A threshold above which we want to enforce regular size class, below that compact size class. */
    let CompactSizeClassWidthThreshold: CGFloat = 375.0
        
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        // If we are large enough, force a regular size class.
        var preferredTrait: UITraitCollection?
        if size.width as CGFloat > CompactSizeClassWidthThreshold {
            preferredTrait = UITraitCollection(horizontalSizeClass: .Regular)
        } else {
            preferredTrait = UITraitCollection(horizontalSizeClass: .Compact)
        }
        
        let childViewController: UIViewController = childViewControllers.first as UIViewController
        setOverrideTraitCollection(preferredTrait, forChildViewController: childViewController)
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
}