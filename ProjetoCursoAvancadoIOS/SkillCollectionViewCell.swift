//
//  SkillCollectionViewCell.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 24/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

class SkillCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet private weak var estrela2: UIImageView!
    @IBOutlet private weak var estrela1: UIImageView!
    @IBOutlet private weak var estrela3: UIImageView!
    @IBOutlet private weak var estrela4: UIImageView!
    @IBOutlet private weak var estrela5: UIImageView!
    var estrelas: [UIImageView]!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        estrelas = [estrela1,estrela2,estrela3,estrela4,estrela5]
    }
    
}