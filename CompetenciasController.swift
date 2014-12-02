//
//  CompetenciasController.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 23/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import UIKit


class CompetenciasController: GlobalController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CompetenciasDetailViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewFlowLayout: TLSpringFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!

    var selectedItem: (index: NSIndexPath, skill: Skills.Skill)?
    var filteredSkills: [Skills.Skill]?
    
    /** IndexPath of a selected item if any or nil. */
    //var selectedItemIndexPath: NSIndexPath?
    
    /*func selectedItem() -> Skills.Skill {
        if let indexPath = selectedItemIndexPath {
            return self.skills?[indexPath.row] as Skills.Skill!
        }
        return Skills.Skill(skillName: "", nStars: 0)
    }*/
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("SkillTitle" , comment: SkillsC)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextDidChange:", name: UITextFieldTextDidChangeNotification, object: nil)

        updateCellsLayout()
        Skills.current.getSkills(){skills in
            self.filteredSkills = skills as? [Skills.Skill]
            self.selectedItem = (NSIndexPath(index: 0), self.filteredSkills?[0] as Skills.Skill!)

            self.collectionView?.reloadData()
        }
        collectionView!.dataSource = self
        collectionView!.delegate = self
       // collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView!.backgroundColor = UIColor.ViewBackground()


        self.view.addSubview(collectionView!)
        
        
        txtSearch.textColor = UIColor.NavigationBarTint()
        txtSearch.backgroundColor = UIColor.NavigationBarSearchBackground()
        txtSearch.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("SearchPlaceholder" ,comment: "Search"),
            attributes:[NSForegroundColorAttributeName: UIColor.NavigationBarTint()])
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let skills = self.filteredSkills {
            return skills.count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as SkillCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        
        if let skill = self.filteredSkills?[indexPath.row] as Skills.Skill! {
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
            controller.detailItem = self.filteredSkills?[index.row] as Skills.Skill!
        }
    }
    
 
    // MARK: DetailViewControllerDelegate
    
    func detailViewController(controller: CompetenciasDetailViewController, didFinishWithUpdatedItem item: Skills.Skill) {

        setSkillAtIndex(selectedItem!.index.row, item: item)
        txtSearch.text = ""
        searchSkills()
        collectionView.reloadData()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var key = "listSkills"
        
       

        
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(filteredSkills!), forKey: key)
        
        defaults.synchronize()
        
    }
    
    
    func setSkillAtIndex(index: Int, item: Skills.Skill){
        filteredSkills![index].nStars = item.nStars
        filteredSkills![index].skillName = item.skillName
    }

    // MARK : UITextFieldDelegate
 
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        searchSkills()
        return true
    }
    func searchSkills(textTypeChange: Bool = false){
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        txtSearch.addSubview(activityIndicator)
        activityIndicator.frame = txtSearch.bounds
        activityIndicator.startAnimating()
        
        filterSkills(txtSearch.text) {
            results in
            
            activityIndicator.removeFromSuperview()
            
            if results != nil {
                self.filteredSkills = results
                self.collectionView?.reloadData()
                
            }
        }
        if(!textTypeChange){
            txtSearch.resignFirstResponder()
        }
    }
    
    func textFieldTextDidChange(notification: NSNotification) {
        searchSkills(textTypeChange: true)
    }
    
    func filterSkills(searchString: String, completion : (results: [Skills.Skill]?) -> Void){
        
        var searchResult: [Skills.Skill] = Skills.current.searchSkills(searchString)
       completion(results:searchResult)
        
    }
}


