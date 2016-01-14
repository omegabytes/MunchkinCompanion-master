//
//  UserDetailViewController.swift
//  MunchkinCompanion
//
//  Created by Alex Gaesser on 1/31/15.
//  Copyright (c) 2015 AlexGaesser. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITextFieldDelegate /* AddHelperVCDelegate */{

//    var addHelperVC: AddHelperViewController!
    
    var detailUserModel: UserModel!
    var level = 1
    var combat = 0
    var oneShot = 0
    var monsterLevel = 0
    var effectiveCombat = 0
    var netCombatResult = 0
    
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var userCombatLabel: UILabel!
    @IBOutlet weak var userOneShotLabel: UILabel!
    @IBOutlet weak var effectiveCombatLabel: UILabel!
    @IBOutlet weak var netCombatResultLabel: UILabel!
    @IBOutlet weak var combatOutcomeLabel: UILabel!
    @IBOutlet weak var monsterLevelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        updateVariables()
        calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
        
        self.monsterLevelTextField.delegate = self
        
        self.title = detailUserModel.userName
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Papyrus", size: 21.0)!]
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Memory management
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        //      detailUserModel.userName = userNameTextField.text
        detailUserModel.combat = combat
        detailUserModel.level = level
        detailUserModel.oneShot = oneShot
        detailUserModel.monsterLevel = monsterLevel
        detailUserModel.effectiveCombat = effectiveCombat
        detailUserModel.netCombatResult = netCombatResult
        
        appDelegate.saveContext()
        
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
    
    @IBAction func askForHelpButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("showAddHelperVC", sender: self)
    }
    
    // Labels and textfields
    
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
    
    // This funciton validates textfield input
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
        if textField == monsterLevelTextField {
            if string.characters.count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        return result
    }
    
    // Helper functions
    
    func calculateEffectiveCombat (level: Int, combat: Int, oneShot: Int) -> Int {
        let effectiveCombat = level + combat + oneShot
        effectiveCombatLabel.text = "\(effectiveCombat)"
        
        return effectiveCombat
    }
    
    func calculateNetCombatResult (effectiveCombatLevel: Int, monsterLevel: Int) -> Int {
        let netCombatResult = (effectiveCombatLevel - monsterLevel)
        netCombatResultLabel.text = "\(netCombatResult)"
        
        return netCombatResult
    }
    
    func calculateAndUpdate (level: Int, combat: Int, oneShot: Int, monsterLevel: Int) {
        userLevelLabel.text = "\(level)"
        userCombatLabel.text = "\(combat)"
        userOneShotLabel.text = "\(oneShot)"
        
        let monsterLevel = Int(monsterLevelTextField.text!)
       
        effectiveCombat = calculateEffectiveCombat(level, combat: combat, oneShot: oneShot)
        print(effectiveCombat, terminator: "")
        if monsterLevel != nil {
            netCombatResult = calculateNetCombatResult(effectiveCombat, monsterLevel: monsterLevel!)
            print(netCombatResult, terminator: "")
        }
        effectiveCombatLabel.text = "\(effectiveCombat)"
        netCombatResultLabel.text = "\(netCombatResult)"
        
        updateOutcomeLabel()
        
    }
    
    func updateVariables() {
        self.level = Int(detailUserModel.level)
        self.combat = Int(detailUserModel.combat)
        self.oneShot = Int(detailUserModel.oneShot)
        self.monsterLevel = Int(detailUserModel.monsterLevel)
        self.effectiveCombat = Int(detailUserModel.effectiveCombat)
        self.netCombatResult = Int(detailUserModel.netCombatResult)
        
        //        self.userNameTextField.text = detailUserModel.userName
        self.userCombatLabel.text = "\(detailUserModel.combat)"
        self.userLevelLabel.text = "\(detailUserModel.level)"
        self.userOneShotLabel.text = "\(detailUserModel.oneShot)"
    }
    
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        if monsterLevelTextField != nil {
            calculateAndUpdate(level, combat: combat, oneShot: oneShot, monsterLevel: monsterLevel)
        }
        self.view.endEditing(true)
        
    }
    
//    func didFinishAddingHelper(controller: AddHelperViewController) {
//        self.effectiveCombat = Int(controller.helperBonus)
//        controller.navigationController?.popViewControllerAnimated(true)
//    }
    
    
}
