//
//  CompetenciasDetailViewController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 26/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//


import UIKit

protocol CompetenciasDetailViewControllerDelegate : class {
    func detailViewController(controller: CompetenciasDetailViewController, didFinishWithUpdatedItem item: Skills.Skill)
}
class CompetenciasDetailViewController: UIViewController, UITextFieldDelegate  {
    var detailItem: Skills.Skill?
    
    @IBOutlet weak var txtSkill: UITextField!
    
    //Notificar que o item foi alterado ao ListViewController
    var delegate: CompetenciasDetailViewControllerDelegate?
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextDidChange:", name: UITextFieldTextDidChangeNotification, object: nil)
        self.view.backgroundColor = UIColor.ViewBackground()        
        
        txtSkill.placeholder = NSLocalizedString("SkillDetailtxtPlaceholder" ,comment: "Skill Name")
        txtSkill.text = detailItem?.skillName
        
        var estrela: UIButton
        for i in 1..<6{
            estrela = self.view.viewWithTag(i) as UIButton
            estrela.setImage(UIImage(named: i<=detailItem?.nStars ? "star-highlighted.png" : "star.png"), forState: UIControlState.Normal)
        }
        super.viewDidLoad()
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
        detailItem?.nStars = tag
        delegate?.detailViewController(self, didFinishWithUpdatedItem: detailItem!)
    }
    // MARK: UITextFieldDelegate
    
    func textFieldTextDidChange(notification: NSNotification) {
        detailItem?.skillName = txtSkill.text
        delegate?.detailViewController(self, didFinishWithUpdatedItem: detailItem!)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        userActivity?.invalidate()
        textField.resignFirstResponder()
        detailItem?.skillName = txtSkill.text
        delegate?.detailViewController(self, didFinishWithUpdatedItem: detailItem!)
        return true
    }
    
}