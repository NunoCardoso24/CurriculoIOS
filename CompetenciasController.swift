//
//  CompetenciasController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 23/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit


class CompetenciasController: GlobalController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, CompetenciasDetailViewControllerDelegate {
    
    @IBOutlet weak var viewFlowLayout: TLSpringFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!

    var selectedItem:(index: NSIndexPath, skill: Skills.Skill)?
    var skills: [Skills.Skill]?
    var filteredSkills: [Skills.Skill]?
    
    /** IndexPath of a selected item if any or nil. */
    //var selectedItemIndexPath: NSIndexPath?
    
    /*func selectedItem() -> Skills.Skill {
        if let indexPath = selectedItemIndexPath {
            return self.skills?[indexPath.row] as Skills.Skill!
        }
        return Skills.Skill(skillName: "", nStars: 0)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("SkillTitle" , comment: SkillsC)
        
        updateCellsLayout()
        Skills.current.getSkills(){skills in
            self.skills = skills as? [Skills.Skill]
            self.filteredSkills = skills as? [Skills.Skill]
            self.collectionView?.reloadData()
        }
        collectionView!.dataSource = self
        collectionView!.delegate = self
       // collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView!.backgroundColor = UIColor.ViewBackground()


        self.view.addSubview(collectionView!)
        
        
        
        selectedItem = (NSIndexPath(index: 0), self.skills?[0] as Skills.Skill!)
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let skills = self.skills {
            return skills.count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as SkillCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        
        if let skill = self.skills?[indexPath.row] as Skills.Skill! {
            cell.lbl.text = "\(skill.skillName)"
            for i in 0..<5{
                cell.estrelas[i].image = UIImage(named: i<skill.nStars ? "star-highlighted.png" : "star.png")
               // cell.estrelas[i].highlighted = true
            }
        }
        
        return cell
    }
    
    func updateCellsLayout(){
        var device = UIDevice.currentDevice().model
         var spacing, height: CGFloat
        if(device == "iPad"){
            //tablet
            spacing = 40
            height = 100
        } else
        {
            //telemovel
            spacing = 20
            height = 75
        }
        
        viewFlowLayout.sectionInset = UIEdgeInsets(top: spacing/2, left: spacing/2, bottom: spacing/2, right: spacing/2)
        viewFlowLayout.itemSize = CGSize(width: view.bounds.width-spacing, height: height)
        viewFlowLayout.minimumInteritemSpacing = spacing
        viewFlowLayout.minimumLineSpacing = spacing/2
        
    }
    override func rotated(){
        super.rotated()
        updateCellsLayout()
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       // selectedItemIndexPath = indexPath
        selectedItem!.index = indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let controller = segue.destinationViewController as CompetenciasDetailViewController
        controller.delegate = self
        var indexPaths = self.collectionView.indexPathForCell(sender as UICollectionViewCell)
        if let index = indexPaths {
            controller.detailItem = self.skills?[index.row] as Skills.Skill!
        }
    }
    
 
    // MARK: DetailViewControllerDelegate
    
    func detailViewController(controller: CompetenciasDetailViewController, didFinishWithUpdatedItem item: Skills.Skill) {
        // Did user edit an item, or added a new item?
      
        setSkillAtIndex(selectedItem!.index.row, item: item)
        collectionView.reloadData()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var key = "listSkills"
        
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(skills!), forKey: key)
        
        defaults.synchronize()

    }
    func setSkillAtIndex(index: Int, item: Skills.Skill){
        skills![index].nStars = item.nStars
        skills![index].skillName = item.skillName

    }
    
    // MARK: - Search
    

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredSkills = self.skills!.filter({( candy : Skills.Skill) -> Bool in
            var categoryMatch = (scope == "All") || (candy.skillName == scope)
            var stringMatch = candy.skillName.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
        self.filterContentForSearchText(searchString, scope: selectedScope)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!,
        shouldReloadTableForSearchScope searchOption: Int) -> Bool {
            let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
            self.filterContentForSearchText(self.searchDisplayController!.searchBar.text, scope: scope[searchOption])
            return true
    }
    
}


