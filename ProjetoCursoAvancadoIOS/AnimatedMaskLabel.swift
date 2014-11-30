//
//  AnimatedMaskLabel.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 21/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit
import QuartzCore
import CoreText

class AnimatedMaskLabel: UIView {
    
    var gradientLayer: CAGradientLayer = CAGradientLayer()

    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        var text = NSLocalizedString("LaunchTap", comment: "Tap")
        //set the background color
        backgroundColor = UIColor.clearColor()
        clipsToBounds = true
        
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 3 * bounds.size.width, height: bounds.size.height)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        var colors: [AnyObject] = [
            UIColor.blackColor().CGColor,
            UIColor.whiteColor().CGColor,
            UIColor.blackColor().CGColor
        ]
        gradientLayer.colors = colors
        
        var locations: [AnyObject] = [
            0.25,
            0.5,
            0.75
        ]
        gradientLayer.locations = locations
        
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.65, 1.0, 1.0]
        gradientAnimation.duration = 2.0
        gradientAnimation.repeatCount = 1_000_000
        gradientAnimation.removedOnCompletion = false
        gradientAnimation.fillMode = kCAFillModeForwards
        
        gradientLayer.addAnimation(gradientAnimation, forKey: nil)
        
        let font = UIFont(name: "HelveticaNeue-Thin", size: 32.0)
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        text.drawInRect(bounds, withAttributes: [
            NSFontAttributeName: font!,
            NSParagraphStyleAttributeName: style
            ]
        )
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.clearColor().CGColor
        maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
        maskLayer.contents = image.CGImage
        
        gradientLayer.mask = maskLayer
    }
    
}