//
//  CompetenciasDetailViewController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 26/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//


import UIKit


class CompetenciasDetailViewController: UIViewController {
    var item: Skills.Skill?
    
    @IBOutlet weak var txtSkill: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.ViewBackground()        
        
        txtSkill.placeholder = NSLocalizedString("SkillDetailtxtPlaceholder" ,comment: "Skill Name")
        txtSkill.text = item?.skillName
        
        var estrela: UIButton
        for i in 1..<6{
            estrela = self.view.viewWithTag(i) as UIButton
            estrela.setImage(UIImage(named: i<=item?.nStars ? "star-highlighted.png" : "star.png"), forState: UIControlState.Normal)
        }
    }
    @IBAction func starClicked(sender: UIButton) {
        var tag = sender.tag
        var estrela: UIButton
        for i in 1..<6{
            estrela = self.view.viewWithTag(i) as UIButton
            
            let toImage = UIImage(named: i<=tag ? "star-highlighted.png" : "star.png")
            UIView.transitionWithView(estrela,
                duration:0.7,
                options: .TransitionCrossDissolve,
                animations: { estrela.setImage(toImage, forState: UIControlState.Normal) },
                completion: nil)
            
          //  estrela.setImage(UIImage(named: i<=tag ? "star-highlighted.png" : "star.png"), forState: UIControlState.Normal)
        }
    }
}