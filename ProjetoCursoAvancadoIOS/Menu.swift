//
//  Menu.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 08/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

public var aboutMe = "About Me"
public var Contacts = "Contacts"
public var Experience = "Professional Experience"
public var SkillsC = "Skills"
public var CV = "CV's"
public var Formation = "Academic Training"

private var Menu0ID = "about"
private var Menu1ID = "formacao"
private var Menu2ID = "competencias"
private var Menu3ID = "Experience"
private var Menu4ID = "Temp"

class Menu {
    class var current:Menu{
        struct Singleton {
            static var instance: Menu?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Singleton.token) {
            Singleton.instance = Menu()
        }
        return Singleton.instance!
    }
    private var menuItems :[(ID: String, text: String)] =
    [
        (Menu0ID, NSLocalizedString("AboutMeTitle" ,comment: aboutMe)),
        //(Menu1ID, NSLocalizedString("ContactsTitle" ,comment: Contacts)),
        (Menu1ID, NSLocalizedString("FormationTitle" ,comment: Formation)),
        (Menu2ID, NSLocalizedString("SkillTitle" ,comment: SkillsC)),
        (Menu3ID, NSLocalizedString("ExperienceTitle" ,comment: Experience)),
        (Menu4ID, NSLocalizedString("CVTitle" ,comment: CV))
    ]
    
    func getIdentifier(position: Int) -> String{
        return menuItems[position].ID
    }
    func getValue(position: Int) -> String{
        return menuItems[position].text
    }
    func numberOfRows() -> Int{
        return menuItems.count
    }
}