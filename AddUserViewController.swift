//
//  AddUserViewController.swift
//  MunchkinCompanion
//
//  Created by Alex Gaesser on 1/31/15.
//  Copyright (c) 2015 AlexGaesser. All rights reserved.
//

import UIKit
import CoreData

class AddUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var userCombatLabel: UILabel!
    @IBOutlet weak var userOneShotLabel: UILabel!
    @IBOutlet weak var effectiveCombatLabel: UILabel!
    @IBOutlet weak var netCombatResultLabel: UILabel!
    @IBOutlet weak var combatOutcomeLabel: UILabel!
    @IBOutlet weak var monsterLevelTextField: UITextField!

    
    var level = 1
    var combat = 0
    var oneShot = 0
    var monsterLevel = 0
    var effectiveCombat = 0
    var netCombatResult = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.monsterLevelTextField.delegate = self

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Memory management

    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("UserModel", inManagedObjectContext: managedObjectContext!)
        let user = UserModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        user.userName = userNameTextField.text
        user.level = level
        print("\(user.level)")
        user.combat = combat
        print("\(user.combat)")
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "UserModel")
        var error:NSError? = nil
        
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            print(res)
        }
        print("done button")


        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // Stat buttons
    
    @IBAction func decrementLevelButtonPressed(sender: UIButton) {
        if level > 1 {
            level -= 1
            calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
        }
    }
    
    @IBAction func incrementLevelButtonPressed(sender: UIButton) {
        if level < 10 {
            level += 1
            calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
        }
    }
    
    @IBAction func decrementCombatButtonPressed(sender: UIButton) {
        combat -= 1
        calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
    }
    
    @IBAction func incrementCombatButtonPressed(sender: UIButton) {
        combat += 1
        calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
    }
    
    @IBAction func decrementOneShotButtonPressed(sender: UIButton) {
        oneShot -= 1
        calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
    }
    
    @IBAction func incrementOneShotButtonPressed(sender: UIButton) {
        oneShot += 1
        calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
    }
    
    // labels and textFields
    
  
    @IBAction func monsterLevelTextFieldEditingDidEnd(sender: UITextField) {
        monsterLevelTextField.resignFirstResponder()
    }
    
    func updateOutcomeLabel() {
        if netCombatResult <= 0 {
            combatOutcomeLabel.textColor = UIColor.redColor()
            combatOutcomeLabel.text = "Run away!"
        } else {
            combatOutcomeLabel.textColor = UIColor.greenColor()
            combatOutcomeLabel.text = "Winning!"
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        return true
    }
    
    // this function validates what characters are allowed in a text field
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
        if textField == monsterLevelTextField {
            if count(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        return result
    }
    
    // Helper functions
    
    func calculateEffectiveCombat (level: Int, combat: Int, oneShot: Int) -> Int {
        var effectiveCombat = level + combat + oneShot
        effectiveCombatLabel.text = "\(effectiveCombat)"
        
        return effectiveCombat
    }
    
    func calculateNetCombatResult (effectiveCombatLevel: Int, monsterLevel: Int) -> Int {
      var netCombatResult = (effectiveCombatLevel - monsterLevel)
        netCombatResultLabel.text = "\(netCombatResult)"
        
        return netCombatResult
    }
    
    func calculateAndUpdate (level: Int, combat: Int, oneShot: Int, monsterLevel: Int) {
        userLevelLabel.text = "\(level)"
        userCombatLabel.text = "\(combat)"
        userOneShotLabel.text = "\(oneShot)"
        
        var monsterLevel = monsterLevelTextField.text.toInt()
        
        effectiveCombat = calculateEffectiveCombat(level, combat: combat, oneShot: oneShot)
        print(effectiveCombat)
        if monsterLevel != nil {
        netCombatResult = calculateNetCombatResult(effectiveCombat, monsterLevel: monsterLevel!)
        print(netCombatResult)
        }
        effectiveCombatLabel.text = "\(effectiveCombat)"
        netCombatResultLabel.text = "\(netCombatResult)"
        
        updateOutcomeLabel()
        
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        if monsterLevelTextField != nil {
        calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
        }
        self.view.endEditing(true)
        
    }
    
    
    
    

}
