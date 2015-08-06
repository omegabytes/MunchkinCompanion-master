//
//  AddHelperViewController.swift
//  MunchkinCompanion
//
//  Created by Alex Gaesser on 2/16/15.
//  Copyright (c) 2015 AlexGaesser. All rights reserved.
//

import UIKit
import CoreData

@objc protocol AddHelperVCDelegate {
    func didFinishAddingHelper(controller: AddHelperViewController)
}

class AddHelperViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()

    var delegate:AddHelperVCDelegate?
    let addHelperVC = AddHelperViewController()
//    addHelperVC.delegate = self

    var helperBonus:NSNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisUser = fetchedResultsController.objectAtIndexPath(indexPath) as! UserModel
        
        var cell:UserCell = tableView.dequeueReusableCellWithIdentifier("helperCell") as! UserCell
        
        cell.nameLabel.text = thisUser.userName
        cell.levelLabel.text = "\(thisUser.level)"
        cell.combatLabel.text = "\(thisUser.effectiveCombat)"
        
        return cell
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var indexPathForRow = tableView.indexPathForSelectedRow()
        println("indexPath for selected row is: \(indexPathForRow)")
        
        let thisUser = fetchedResultsController.objectAtIndexPath(indexPath) as! UserModel
        var cell:UserCell = tableView.dequeueReusableCellWithIdentifier("helperCell") as! UserCell
        
        helperBonus = thisUser.effectiveCombat
        helperBonus = Int(helperBonus)
        
        println("helperBonus is: \(helperBonus)")

        delegate?.didFinishAddingHelper(self)
        
//        navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    func userFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "UserModel")
        let sortDescriptor = NSSortDescriptor(key: "level", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: userFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
    
    
}
