//
//  Animations.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 07/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

public class TransitionAnimations
{
    
    public class func PresentDrop(fromVC:UIViewController, toVC:UIViewController, transitionContext: UIViewControllerContextTransitioning)
    {
        
        var center = toVC.view.center
        //MARK : Add Shadow
        
        var shadowPath = UIBezierPath(rect:toVC.view.bounds);
        toVC.view.layer.masksToBounds = true;
        toVC.view.layer.shadowColor = UIColor.blackColor().CGColor;
        toVC.view.layer.shadowOffset = CGSizeMake(0.0, 5.0);
        toVC.view.layer.shadowOpacity = 0.5;
        toVC.view.layer.shadowPath = shadowPath.CGPath;
        
        toVC.view.frame = CGRectOffset(toVC.view.frame, 0, -toVC.view.frame.size.height - 100)
        
        transitionContext.containerView().addSubview(toVC.view)
        
        var animator:UIDynamicAnimator? = UIDynamicAnimator(referenceView: transitionContext.containerView())
        
        var gravity = UIGravityBehavior(items: [toVC.view])
        //gravity.magnitude = 10
        var collisionBehaviour = UICollisionBehavior(items: [toVC.view])
        collisionBehaviour.addBoundaryWithIdentifier("Bottom", fromPoint: CGPointMake(0, fromVC.view.frame.size.height+64), toPoint: CGPointMake(fromVC.view.frame.size.width, fromVC.view.frame.size.height+64))
        var propertiesBehaviour = UIDynamicItemBehavior(items: [toVC.view])
        propertiesBehaviour.elasticity = 0.4
        
        animator?.addBehavior(gravity)
        animator?.addBehavior(propertiesBehaviour)
        animator?.addBehavior(collisionBehaviour)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3.0) * Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) {
            animator = nil
            toVC.view.layer.masksToBounds = true
            toVC.view.layer.shadowColor = nil
            toVC.view.layer.shadowOffset = CGSizeZero
            toVC.view.layer.shadowOpacity = 0
            toVC.view.layer.shadowPath = nil
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    public class func DissmissDrop(fromVC:UIViewController, toVC:UIViewController, transitionContext: UIViewControllerContextTransitioning)
    {
        transitionContext.containerView().insertSubview(toVC.view, belowSubview: fromVC.view)
        //MARK : Add Shadow
        
        var shadowPath = UIBezierPath(rect:fromVC.view.bounds);
        fromVC.view.layer.masksToBounds = true;
        fromVC.view.layer.shadowColor = UIColor.blackColor().CGColor;
        fromVC.view.layer.shadowOffset = CGSizeMake(0.0, 5.0);
        fromVC.view.layer.shadowOpacity = 0.5;
        fromVC.view.layer.shadowPath = shadowPath.CGPath;
        
        fromVC.view.frame = CGRectOffset(fromVC.view.frame, 0, 0)
        
        transitionContext.containerView().addSubview(fromVC.view)
        
        var animator:UIDynamicAnimator? = UIDynamicAnimator(referenceView: transitionContext.containerView())
        
        var gravity = UIGravityBehavior(items: [fromVC.view])
        gravity.magnitude = 10
        var collisionBehaviour = UICollisionBehavior(items: [fromVC.view])
        collisionBehaviour.addBoundaryWithIdentifier("Bottom", fromPoint: CGPointMake(0, fromVC.view.frame.size.height*2+200), toPoint: CGPointMake(fromVC.view.frame.size.width, fromVC.view.frame.size.height*2+200))
        
        var propertiesBehaviour = UIDynamicItemBehavior(items: [fromVC.view])
        propertiesBehaviour.elasticity = 0.0
        
        animator?.addBehavior(gravity)
        animator?.addBehavior(propertiesBehaviour)
        animator?.addBehavior(collisionBehaviour)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0) * Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) {
            animator = nil
            fromVC.view.layer.masksToBounds = true
            fromVC.view.layer.shadowColor = nil
            fromVC.view.layer.shadowOffset = CGSizeZero
            fromVC.view.layer.shadowOpacity = 0
            fromVC.view.layer.shadowPath = nil
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
    
    public class func DissmissSpin(fromVC:UIViewController, toVC:UIViewController, transitionContext: UIViewControllerContextTransitioning)
    {
        
        var center = toVC.view.center
        //Add Shadow
        var shadowPath = UIBezierPath(rect:fromVC.view.bounds);
        fromVC.view.layer.masksToBounds = true;
        fromVC.view.layer.shadowColor = UIColor.blackColor().CGColor;
        fromVC.view.layer.shadowOffset = CGSizeMake(0.0, 5.0);
        fromVC.view.layer.shadowOpacity = 0.5;
        fromVC.view.layer.shadowPath = shadowPath.CGPath;
        
        
        transitionContext.containerView().insertSubview(toVC.view, belowSubview: fromVC.view)
        
        var animator:UIDynamicAnimator? = UIDynamicAnimator(referenceView: transitionContext.containerView())
        
        var gravity = UIGravityBehavior(items: [fromVC.view])
        
        var anchorPoint = CGPointMake(fromVC.view.frame.size.width, fromVC.view.frame.size.height)
        
        var offSet1 = UIOffsetMake(center.x, center.y)
        var attachment1 = UIAttachmentBehavior(item: fromVC.view, offsetFromCenter: offSet1, attachedToAnchor: anchorPoint)
        attachment1.length = 10
        
        var offSet2 = UIOffsetMake(center.x - 100, center.y)
        var attachment2 = UIAttachmentBehavior(item: fromVC.view, offsetFromCenter: offSet2, attachedToAnchor: anchorPoint)
        attachment2.length = 100.5
        
        var pushBehaviour = UIPushBehavior(items: [fromVC.view], mode: UIPushBehaviorMode.Instantaneous)
        pushBehaviour.angle = 0
        pushBehaviour.magnitude = 200
        
        
        
        animator?.addBehavior(gravity)
        animator?.addBehavior(attachment1)
        animator?.addBehavior(attachment2)
        animator?.addBehavior(pushBehaviour)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3.0) * Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) {
            animator = nil
            fromVC.view.layer.masksToBounds = true
            fromVC.view.layer.shadowColor = nil
            fromVC.view.layer.shadowOffset = CGSizeZero
            fromVC.view.layer.shadowOpacity = 0
            fromVC.view.layer.shadowPath = nil
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            
        }
    }
    
    public class func DissmissPop(fromVC:UIViewController, toVC:UIViewController, transitionContext: UIViewControllerContextTransitioning, duration: NSTimeInterval)
    {
        transitionContext.containerView().insertSubview(toVC.view, belowSubview: fromVC.view)
        
        UIView.animateWithDuration(duration, animations: {
            fromVC.view.transform = CGAffineTransformMakeScale(0.01, 0.01)
            }, completion: {_ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    public class func PresentPop(fromVC:UIViewController, toVC:UIViewController, transitionContext: UIViewControllerContextTransitioning, duration: NSTimeInterval)
    {
        transitionContext.containerView().insertSubview(toVC.view, aboveSubview: fromVC.view)
        toVC.view.transform = CGAffineTransformMakeScale(0.01, 0.01)
        UIView.animateWithDuration(duration, animations: {
            toVC.view.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: {_ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
    public class func Slide(fromVC:UIViewController, toVC:UIViewController, transitionContext: UIViewControllerContextTransitioning, duration: NSTimeInterval, transitionStep: TransitionStep)
    {
        let container = transitionContext.containerView()
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        // start the toView to the right of the screen
        if(transitionStep == .Present){
            //toVC.view.frame = CGRectOffset(toVC.view.frame, -toVC.view.frame.size.width , 0)
            toVC.view.transform = offScreenRight
        }
        else{
            toVC.view.transform = offScreenLeft
        }
        // add the both views to our view controller
        transitionContext.containerView().insertSubview(toVC.view, belowSubview: fromVC.view)
        //container.addSubview(toVC.view)
        //container.addSubview(fromVC.view)
        
        // perform the animation!
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
            if(transitionStep == .Present){
                //fromVC.view.frame = CGRectOffset(toVC.view.frame, -toVC.view.frame.size.width , 0)
                fromVC.view.transform = offScreenLeft
                toVC.view.transform = offScreenLeft
            } else
            {
                
                fromVC.view.transform = offScreenRight
                toVC.view.transform = offScreenRight
            }
            
            
            toVC.view.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
        })
    }
    public class func DissmissMiddleSeparation(fromVC:UIViewController, toVC:UIViewController, transitionContext: UIViewControllerContextTransitioning)
    {
        transitionContext.containerView().insertSubview(toVC.view, aboveSubview: fromVC.view)
        
        var snapshotRegion = CGRectMake(0, 0, fromVC.view.frame.size.width, fromVC.view.frame.size.height/2)
        var topView = fromVC.view.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        topView.frame = snapshotRegion
        transitionContext.containerView().insertSubview(topView, aboveSubview: toVC.view)
        

        // snapshot the right-hand side of the view
        snapshotRegion = CGRectMake(0, fromVC.view.frame.size.height/2, fromVC.view.frame.size.width, fromVC.view.frame.size.height/2)
        var bottomView = fromVC.view.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        bottomView.frame = snapshotRegion
        transitionContext.containerView().insertSubview(bottomView, aboveSubview: toVC.view)
        

        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
            topView.frame.origin.y = -fromVC.view.frame.size.height/2-70
            }, completion: {_ in
               transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
            bottomView.frame.origin.y = fromVC.view.frame.size.height+70
            }, completion: {_ in
                bottomView.hidden = true
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}