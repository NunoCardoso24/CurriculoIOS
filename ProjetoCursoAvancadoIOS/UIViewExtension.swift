//
//  UIViewExtension.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 21/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit
extension UIView {
    func roundedView(border: CGFloat)
    {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = border
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func Animation(pulseAnimationDuration duration: NSTimeInterval = 0.9, scale: CGFloat = 1.4)
    {
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(scale, scale)
            }, completion: nil)
    }
}
