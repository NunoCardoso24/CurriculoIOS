//
//  MenuButton.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 19/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit
class MenuButton: UIView {
    
    var imageView: UIImageView!
    var sourceView : UIViewController?

  
    override func didMoveToSuperview() {
        frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView = UIImageView(image:UIImage(named:"menu"))
        imageView.userInteractionEnabled = true
        imageView.image = imageView.image?.imageWithTintColor(UIColor.NavigationBarTint())
        imageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: Selector("didTap")))
        imageView.tag = 0
        addSubview(imageView)
    }
    
    func didTap() {
        sourceView?.toggleSideMenuView()
    }
    
}
