//
//  RulesAndFaqsViewController.swift
//  MunchkinCompanion
//
//  Created by Alex Gaesser on 2/11/15.
//  Copyright (c) 2015 AlexGaesser. All rights reserved.
//

import UIKit

class RulesAndFaqsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var rulesFaqsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ruleCell") as UITableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    // MARK - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK - makeRequest
    
        func makeRequest (searchString: String) {
    
            var request = NSMutableURLRequest(URL: NSURL(string: "https://www.boardgamegeek.com/xmlapi2/forum?id=4635")!)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "GET"
    
            var params = [
    
            ]
        }
}
