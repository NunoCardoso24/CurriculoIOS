//
//  Skills.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 24/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit

class Skills:NSObject {
    class var current:Skills{
        struct Singleton {
            static var instance: Skills?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Singleton.token) {
            Singleton.instance = Skills()
        }
        return Singleton.instance!
    }
    
    var listSkills:[Skill]?
    
    struct defaultSkills {
        static var defaultSkills:[Skill] =
        [
            Skill(skillName: "IOS", nStars:5),
            Skill(skillName: "Android", nStars:4),
            Skill(skillName: "Swift", nStars:4),
            Skill(skillName: "Java", nStars:4),
            Skill(skillName: "C#", nStars:4),
            Skill(skillName: "ASP.NET", nStars:4),
            Skill(skillName: "HTML", nStars:4),
            Skill(skillName: "XML", nStars:3),
            Skill(skillName: "JSON", nStars:4),
            Skill(skillName: "REST", nStars:4),
            Skill(skillName: "UML", nStars:3)
        ]
    }
    
    override init() {
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(listSkills, forKey: "listSkills")
    }
    
    required init(coder aDecoder: NSCoder) {
    super.init()
        self.getSkills(){skills in
            self.listSkills = skills as? [Skills.Skill]
        }
    }
    
    class Skill:NSObject {
        var skillName: String!
        var nStars: Int!
        init(skillName:String, nStars:Int){
            self.skillName = skillName
            self.nStars = nStars
        }

        func encodeWithCoder(aCoder: NSCoder) {
            aCoder.encodeObject(skillName, forKey: "skillName")
            aCoder.encodeInteger(self.nStars, forKey: "nStars")
        }
        
        required init(coder aDecoder: NSCoder) {
            skillName = aDecoder.decodeObjectForKey("skillName") as String
            nStars   = aDecoder.decodeIntegerForKey("nStars")
        }
    }
    func setDefaulSkills(){
        let defaults = NSUserDefaults.standardUserDefaults()
        var key = "listSkills"
        
        var array1: [Skill] = defaultSkills.defaultSkills
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(array1), forKey: key)
        
        defaults.setBool(true, forKey: "HasLaunchedOnce")
        defaults.synchronize()
    }
    func getSkills(skills:(NSArray)->())
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var key = "listSkills"
        
        var data = defaults.objectForKey(key) as NSData
        var savedArray = NSKeyedUnarchiver.unarchiveObjectWithData(data) as NSArray
        listSkills = savedArray as? [Skills.Skill]
        
        skills(savedArray)
    }
    func searchSkills(searchFor: NSString) -> [Skill] {
        if(searchFor == ""){
            return listSkills!
        }
        var filteredSkills: [Skill]
        filteredSkills = listSkills!.filter({ s1 -> Bool in
            var str = s1.skillName as NSString
            return str.localizedCaseInsensitiveContainsString(searchFor)
        })
        return filteredSkills
    }
}
