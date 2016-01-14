//
//  MainViewController.swift
//  MunchkinCompanion
//
//  Created by Alex Gaesser on 1/31/15.
//  Copyright (c) 2015 AlexGaesser. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        
        print("viewDidLoad called", terminator: "")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showUserDetailVC" {
            let userDetailVC: UserDetailViewController = segue.destinationViewController as! UserDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            let thisUser = fetchedResultsController.objectAtIndexPath(indexPath!) as! UserModel
            userDetailVC.detailUserModel = thisUser
        } else if segue.identifier == "showAddUserVC" {
            let addUserVC:AddUserViewController = segue.destinationViewController as! AddUserViewController
        }
    }
    
    @IBAction func addUserBarButtonItemPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showAddUserVC", sender: self)
    }
    
    
    // UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath called", terminator: "")
        
        let thisUser = fetchedResultsController.objectAtIndexPath(indexPath) as! UserModel
        
        let cell: UserCell = tableView.dequeueReusableCellWithIdentifier("userCell") as! UserCell
        
        cell.nameLabel.text = thisUser.userName
        cell.levelLabel.text = "\(thisUser.level)"
        cell.combatLabel.text = "\(thisUser.effectiveCombat)"
        
        print("returning cell", terminator: "")
        return cell
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row, terminator: "")
        
        self.performSegueWithIdentifier("showUserDetailVC", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            let thisUser = fetchedResultsController.objectAtIndexPath(indexPath) as! UserModel
            context.deleteObject(thisUser)
            do {
                try context.save()
            } catch _ {
            }

        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // NSFetchedResultControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
        print("DidChangeContent called", terminator: "")
    }
    
    // Helper functions
    
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
