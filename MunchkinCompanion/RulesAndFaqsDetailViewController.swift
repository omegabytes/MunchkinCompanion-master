//
//  RulesAndFaqsDetailViewController.swift
//  MunchkinCompanion
//
//  Created by Alex Gaesser on 2/12/15.
//  Copyright (c) 2015 AlexGaesser. All rights reserved.
//

import UIKit

class RulesAndFaqsDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toRFDetailVC" {
            if sender != nil {
                var rfDetailVC = segue.destinationViewController as! RulesAndFaqsDetailViewController
            }
        }
    }

}
