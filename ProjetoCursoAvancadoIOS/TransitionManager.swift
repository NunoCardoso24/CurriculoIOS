//
//  TransitionManager.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 07/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

public enum TransitionStep : Int
{
    case Dissmiss = 0
    case Present = 1
    case DissmissLaunch = 2
}

class TransitionsManager :NSObject, UIViewControllerAnimatedTransitioning
{
    class var current:TransitionsManager{
        struct Singleton {
            static var instance: TransitionsManager?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Singleton.token) {
            Singleton.instance = TransitionsManager()
        }
        return Singleton.instance!
    }
    
    private var overlayView:UIView?
    
    // MARK: Properties
    var duration:NSTimeInterval = 0
    var action: TransitionStep  = .Present
    
    // MARK: UIViewControllerAnimatedTransitioning Delegate Methods
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) {
            if let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) {
                switch UIApplication.sharedApplication().statusBarOrientation {
                case UIInterfaceOrientation.Portrait:
                    animation(fromVC, toVC: toVC, transitionContext: transitionContext)
                case UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight:
                    animation(fromVC, toVC: toVC, transitionContext: transitionContext)
                    
                default:
                    transitionContext.completeTransition(true)
                }
            }
            else {
                println("Controller de destino não definido")
            }
        }
        else {
            println("Controller de origem não definido")
        }
    }
    
    private func animation(fromVC:UIViewController, toVC:UIViewController, transitionContext: UIViewControllerContextTransitioning)
    {
        if(self.action == .Present) {
            if(toVC is AboutController || toVC is SplitViewController){
                transitionContext.containerView().insertSubview(toVC.view, aboveSubview: fromVC.view)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }else{
                TransitionAnimations.PresentDrop(fromVC, toVC: toVC, transitionContext: transitionContext)
            }
        }
        else if(self.action == .DissmissLaunch){
            TransitionAnimations.DissmissMiddleSeparation(fromVC, toVC: toVC, transitionContext: transitionContext)
        }
        else {
            TransitionAnimations.DissmissDrop(fromVC, toVC: toVC, transitionContext: transitionContext)
            //TransitionAnimations.DissmissPop(fromVC, toVC: toVC, transitionContext: transitionContext, duration: 2)
        }
        
        
    }
    
}